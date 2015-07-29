module Layer
  class Resource

    class << self
      attr_writer :client

      def class_name
        name.split('::')[-1]
      end

      def url
        "/#{class_name.downcase.to_s}s"
      end

      def from_response(attributes, client)
        new(attributes, client)
      end

      def client
        @client ||= Client.new
      end
    end

    attr_accessor :client, :attributes

    def initialize(attributes = {}, client = self.class.client)
      self.attributes = attributes
      self.client = client
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

    def method_missing(method, *args, &block)
      if attributes.has_key?(method.to_s)
        attributes[method.to_s]
      else
        super
      end
    end

  end
end
