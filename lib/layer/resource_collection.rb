module Layer
  class ResourceCollection < Enumerator

    def initialize(resource, client)
      @resource = resource
      @client = client
      @params = { page_size: 100 }

      super() do |yielder|
        while response = next_page
          response.map do |attributes|
            yielder << resource.from_response(attributes, client)
          end
        end
      end
    end

  private

    attr_reader :resource, :client, :params

    def next_page
      response = client.get(resource.url, {}, { params: params })
      return nil if response.empty?
      params[:from_id] = Layer::Client.normalize_id(response.last['id'])
      response
    end

  end
end
