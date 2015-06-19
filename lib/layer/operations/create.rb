module Layer
  module Operations
    module Create

      module ClassMethods
        def create(attributes = {}, client = Client.new)
          response = client.post(url, attributes)
          from_response(response, client)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
