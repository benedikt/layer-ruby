module Layer
  class Content < Resource
    include Operations::Create
    include Operations::Find

    def self.create(mime_type, file, client = self.client)
      response = client.post(url, {}, headers = {
        'Upload-Content-Type' => mime_type,
        'Upload-Content-Length' => file.size
      })

      attributes = response.merge('size' => file.size)

      from_response(attributes, client).tap do |content|
        content.upload(file)
      end
    end

    def self.url
      '/content'
    end

    def upload(file)
      RestClient.put(upload_url, file)
    end

    def url
      attributes['refresh_url'] || "#{self.class.url}/#{Layer::Client.normalize_id(id)}"
    end

    def to_json(*args)
      { id: id, size: size }.to_json(*args)
    end
  end
end
