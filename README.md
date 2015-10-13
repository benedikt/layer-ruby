# Ruby Client for Layer

[![Build Status](https://travis-ci.org/benedikt/layer-ruby.svg?branch=master)](https://travis-ci.org/benedikt/layer-ruby)
[![Gem Version](https://badge.fury.io/rb/layer-ruby.svg)](http://badge.fury.io/rb/layer-ruby)

Ruby client for the [Layer Platform API](https://developer.layer.com/docs/platform) and [Layer Client API](https://developer.layer.com/docs/client).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'layer-ruby', require: 'layer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install layer-ruby

## Usage

Please refer to the [Layer Platform API documentation](https://developer.layer.com/docs/platform) for details about the required payloads and responses.

### Configuration

To use interact with the Layer Platform API, you need your Layer APP ID as well as a Layer Platform API Token. The gem reads both values from the `LAYER_APP_ID` and `LAYER_PLATFORM_TOKEN` environment variables. Alternatively you can specify the values by configuring the `Layer::Client` like this:

```ruby
Layer::Client.configure do |config|
  config.app_id = 'YOUR_APP_ID_HERE'
  config.token = 'YOUR_PLATFORM_TOKEN_HERE'
end
```

### Creating Conversations

```ruby
conversation = Layer::Conversation.create({ participants: ['1', '2'] })
```

### Retrieving Conversations

To retrieve a existing conversation, just use `Conversation.find` passing it the conversation id:

```ruby
conversation = Layer::Conversation.find('CONVERSATION_ID_HERE')
```

### Updating Conversations

To update a conversation, just update the conversation's attributes and call `save`.

```ruby
conversation = Layer::Conversation.find('CONVERSATION_ID_HERE')
conversation.participants << 3
conversation.metadata[:foo] = 'bar'
conversation.save
```


### Sending Messages

In order to send messages, you first have to load (or create) a Conversation. Afterwards you can send a message to the conversation like this:

```ruby
conversation = Layer::Conversation.find('CONVERSATION_ID_HERE')
conversation.messages.create({ sender: { name: 'Server' }, parts: [{ body: 'Hello!', mime_type: 'text/plain' }]})
```

### Sending Announcements

You can send a announcements like this:

```ruby
Layer::Announcement.create({ recipients: 'everyone', sender: { name: 'Server' }, parts: [{ body: 'Hello!', mime_type: 'text/plain' }]})
```

### Managing block lists

Managing block lists is also possible:

```ruby
user = Layer::User.find('user_id')
user.blocks.all # Returns a list of blocks
user.blocks.create({ user_id: 'other_user' }) # Adds the other user to the block list
user.blocks.delete('other_user') # Removes the other user from the block list
user.blocks.all.first.delete # Removes the first entry from the block list
```

### Using the gem with multiple applications at once

It's possible to create a new instance of `Layer::Client` and passing both the app id and the token to the initializer:

```ruby
client = Layer::Client.new('YOUR_APP_ID_HERE', 'YOUR_PLATFORM_TOKEN_HERE')
```

The client will not use any global configuration. You can pass the client as a second parameter to any operations (`create`, `find`) described above.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/benedikt/layer-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Related Work

Check out the [layer-identity_token](https://github.com/dreimannzelt/layer-identity_token) gem to generate authentication tokens for the Layer SDK.
