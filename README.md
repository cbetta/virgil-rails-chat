# Rails Chat application with Virgil Security

This is an example of how to use the [Virgil Security APIs](https://virgilsecurity.com/) using the official JS and Ruby SDKs to implement end to end encryption in a chat application.

## Technology

This demo uses

* [Ruby 2.2.2+](https://www.ruby-lang.org/)
* [Rails 5.1](http://rubyonrails.org/)
* The [Virgil Security SDKs](https://virgilsecurity.com/) for JS and Ruby

## Running the demo locally

* Clone this repository
* Run `bundle` to install all dependencies
* Run `rake db:setup` to initialize the database
* Run `rails server` to start the app
* Visit `http://localhost:5000/` and register
* In a separate browser or on a different machine create a second account.
* Select the other user in the UI
* Start a conversation

All messages are client side encrypted and can not be read by the server. To inspect this behaviour, open a `rails console` and run `Message.pluck(:content)` to inspect the message content.

## Before/After encryption

There are 2 special branches of this repo, the [before](https://github.com/cbetta/virgil-rails-chat/tree/before) and [after](https://github.com/cbetta/virgil-rails-chat/tree/after) branch show the state of this application in their respective before and after adding end-to-end-encryption states.

Here are [the exact differences](https://github.com/cbetta/virgil-rails-chat/compare/before...after) between these 2 branches.

## Caveats

This repository includes the `app.virgilkey`, key password, app ID, and access token. In a production environment these should probably not live with your code but somewhere separated like environment variables.

## Useful links

* The Virgil Security [Ruby SDK](https://github.com/VirgilSecurity/virgil-sdk-ruby)
* The Virgil Security [Javascript SDK](https://github.com/VirgilSecurity/virgil-sdk-javascript)
* [Get Started](https://developer.virgilsecurity.com/docs/javascript/get-started/encrypted-communication) with Encrypted Communication
