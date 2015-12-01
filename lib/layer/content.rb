module Layer
  # @example
  #   content = Layer::Content.create('image/png', File.open('photo.png'))
  #
  #   message = Layer::Message.create({
  #     sender: { name: 'Server' },
  #     parts: [
  #       { content: content, mime_type: 'image/png' }
  #     ]
  #   })
  #
  # @see https://developer.layer.com/docs/client/rest#rich-content Layer REST API documentation about rich content
  # @!macro rest-api
  class Content < Resource
    include Operations::Create
    include Operations::Find

    # @!parse extend Layer::Operations::Create::ClassMethods
    # @!parse extend Layer::Operations::Find::ClassMethods

    def self.create(mime_type, file, client = self.client)
      response = client.post(url, {}, {
        'Upload-Content-Type' => mime_type,
        'Upload-Content-Length' => file.size
      })

      attributes = response.merge('size' => file.size, 'mime_type' => mime_type)

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

    def as_json(*args)
      { id: id, size: size }
    end

    def to_json(*args)
      as_json.to_json(*args)
    end

  end
end
