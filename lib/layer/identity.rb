module Layer
  # Managing user identity is also possible:
  #
  # @example
  #   user = Layer::User.find('user_id')
  #   user.identity.get # Returns user identity
  #   user.identity.create({ first_name: 'Frodo', last_name: 'Baggins'}) # Creates new identity
  #   user.identity.delete # Removes identity
  #
  # @see https://developer.layer.com/docs/platform#identity Layer Platform API Documentation about identity
  # @!macro platform-api
  class Identity < Resource
    def self.url
      '/identity'
    end
  end
end
