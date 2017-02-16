module Layer
  # Managing user identity is also possible:
  #
  # @example
  #   user = Layer::User.find('user_id')
  #   user.identity # Returns user identity
  #   user.identity.create({ first_name: 'Frodo', last_name: 'Baggins'}) # Creates new identity
  #   user.identity.delete # Removes identity
  #
  # @see https://developer.layer.com/docs/platform#identity Layer Platform API Documentation about identity
  # @!macro platform-api
  class Identity < Resource
    include Operations::Fetch
    include Operations::Delete
    include Operations::Patch

    def self.url
      '/identity'
    end

    def attributes=(attributes)
      attributes['metadata'] ||= {}
      super
    end
  end
end
