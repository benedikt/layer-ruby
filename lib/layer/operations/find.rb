module Layer
  module Operations
    module Find

      module ClassMethods
        def find(id, client = Client.new)
          response = client.get("#{url}/#{id}")
          from_response(response, client)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      def reload
        @attributes = client.get(url)
        self
      end

    end
  end
end

