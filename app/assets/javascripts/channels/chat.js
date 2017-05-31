$(function(){
  var chatId = $('#chat').data('id');
  var api = virgil.API("AT.1cde554c5a649b17fd9e07157e1a7db7fac61d71218b71082635795b6356e8eb");
  var myUsername = $('#chat').data('me');
  var theirUsername = $('#chat').data('them');
  var myKey = null;

  // Initialize our channel
  App.chat = App.cable.subscriptions.create({
    channel: "ChatChannel",
    id: $('#chat').data('id')
  }, {
    connected: function () {
      api.keys.load(myUsername)
        .then(initKey)
        .catch(createKeyAndCard)
        // this always happens
        .then(initUI);
    },

    // when we receive a new message, show it
    received: function(data) {
      $('#messages').append(data.message);
      decryptMessages();
    },

    // when a new message is ready,
    // we send the message over the ActionCable
    speak: function(message) {
      api.cards.find([myUsername, theirUsername])
        .then(function(cards) {
          var cipher = myKey.signThenEncrypt(message, cards).toString('base64');
          App.chat.perform('speak', {
            message: cipher,
            id: chatId
          });
        });
    },

    publishCard: function(card) {
      this.perform('publishCard', {
        card: card.export()
      });
    }
  });

  function initKey(key) {
    myKey = key;
  }

  function createKeyAndCard() {
    myKey = api.keys.generate();
    myKey.save(myUsername);
    var card = api.cards.create(myUsername, myKey);
    App.chat.publishCard(card);
  }

  function initUI() {
    $('#message_composer').show();
    decryptMessages();
  }

  function decryptMessages() {
    $(".message .content[data-encrypted=true]").each(function(element) {
      var message = $(this);
      var cipher = message.text();
      var sender = message.data('sender');
      api.cards.find(sender)
        .then(function(cards){
          var plainText = myKey.decryptThenVerify(cipher, cards).toString();
          message.text(plainText);
          message.attr("data-encrypted", 'false');
        });
    });
  }

  // send a new message and clear the composer
  $('#message_composer').on('keypress', function(event) {
    if (event.keyCode === 13) {
      App.chat.speak(event.target.value);
      event.target.value = '';
      event.preventDefault();
    }
  });
});
