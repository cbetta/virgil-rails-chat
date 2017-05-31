$(function(){
  var chatId = $('#chat').data('id');
  // TODO: (1) Initialize Virgil API
  // TODO: (2) Determine sender and receiver
  // TODO: (3) Declare my Virgil private key

  // Initialize our channel
  App.chat = App.cable.subscriptions.create({
    channel: "ChatChannel",
    id: $('#chat').data('id')
  }, {
    connected: function () {
      // TODO: (4) Try to load my private key, if there us none
      // we will want to create it and register a Virgil Card
      // for it
    },

    // when we receive a new message, show it
    received: function(data) {
      $('#messages').append(data.message);
      // TODO: (19) decrypt any new messages
    },

    // when a new message is ready,
    // we send the message over the ActionCable
    speak: function(message) {
      // TODO: (15) Encrypt the message before we send it
      App.chat.perform('speak', {
        message: message,
        id: chatId
      });
    }

    // TODO: (8) Define a new cable method to publish
    // a Virgil Card to the server
  });

  // TODO: (5) Set myKey to the loaded or created key

  // TODO: (6) Define a method that creates a key and card,
  // and then publishes it

  // TODO: (7) Define a method that Initializes the UI once a
  // private key is ready

  // TODO: (20) Update initUI method to decrypt messages
  // on first load

  // TODO: (18) Define a method that decrypts any
  // encrypted messages in the UI

  // send a new message and clear the composer
  $('#message_composer').on('keypress', function(event) {
    if (event.keyCode === 13) {
      App.chat.speak(event.target.value);
      event.target.value = '';
      event.preventDefault();
    }
  });
});
