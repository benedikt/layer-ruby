module Layer
  class Resource

    class << self
      def class_name
        name.split('::')[-1]
      end

      def url
        "/#{class_name.downcase.to_s}s"
      end

      def from_response(attributes, client)
        new(attributes, client)
      end
    end

    def initialize(attributes = {}, client = Client.new)
      @attributes = attributes
      @client = client
    end

    def url
      attributes['url']
    end

    def id
      attributes['id']
    end

    def respond_to_missing?(method, include_private = false)
      attributes.has_key?(method.to_s) || super
    end

  private

    attr_reader :attributes, :client

    def method_missing(method, *args, &block)
      if attributes.has_key?(method.to_s)
        attributes[method.to_s]
      else
        super
      end
    end

  end
end
