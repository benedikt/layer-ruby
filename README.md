# Ruby Client for Layer

[![Build Status](https://travis-ci.org/benedikt/layer-ruby.svg?branch=master)](https://travis-ci.org/benedikt/layer-ruby)
[![Gem Version](https://badge.fury.io/rb/layer-ruby.svg)](http://badge.fury.io/rb/layer-ruby)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/gems/layer-ruby)

Ruby client for the [Layer Platform API](https://developer.layer.com/docs/platform) and [Layer Client REST API](https://developer.layer.com/docs/client/rest).

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

Please refer to the [Layer Platform API documentation](https://developer.layer.com/docs/platform) and [Layer Client REST API documentation](https://developer.layer.com/docs/client/rest) for details about the required payloads and responses.

### Configuration

To use the Layer Platform API, you need your Layer APP ID as well as a Layer Platform API Token. The gem reads both values from the `LAYER_APP_ID` and `LAYER_PLATFORM_TOKEN` environment variables. Alternatively you can specify the values by configuring the `Layer::Client` like this:

```ruby
Layer::Client.configure do |config|
  config.app_id = 'YOUR_APP_ID_HERE'
  config.token = 'YOUR_PLATFORM_TOKEN_HERE'
end
```

### Using the gem with multiple applications at once

It's possible to create a new instance of `Layer::Client::Platform` and passing both the app id and the token to the initializer:

```ruby
platform_client = Layer::Client::Platform.new('YOUR_APP_ID_HERE', 'YOUR_PLATFORM_TOKEN_HERE')
```

The client will not use any global configuration. You can pass the client as a second parameter to any operations (`create`, `find`) described above.

### Using the Layer Client REST API

To use the Layer Client REST API, you need a way to generate identitiy tokens. You might want to use the [layer-identity_token](https://github.com/dreimannzelt/layer-identity_token) gem for that. Using this gem, you can create a new client using the REST API like this:

```ruby
client = Layer::Client.authenticate { |nonce| Layer::IdentityToken.new('user_id_here', nonce) }
```

Afterwards, pass the client as an additional argument to the resource's methods:

```ruby
# Finds all conversations of the authenticated user
Layer::Conversation.all(client)
```

### Documentation

Please refer to [the full documentation](http://rubydoc.info/gems/layer-ruby) for details on how to use Announcements, Block Lists, Conversations, Messages, Rich Content, and WebHooks.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/benedikt/layer-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Related Work

Check out the [layer-identity_token](https://github.com/dreimannzelt/layer-identity_token) gem to generate authentication tokens for the Layer SDK.
