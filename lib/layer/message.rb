module Layer
  # @example Sending messages
  #   conversation = Layer::Conversation.find('CONVERSATION_ID_HERE')
  #   conversation.messages.create({ sender: { name: 'Server' }, parts: [{ body: 'Hello!', mime_type: 'text/plain' }]})
  #
  # @see https://developer.layer.com/docs/platform#send-a-message Layer Platform API Documentation about messages
  # @see https://developer.layer.com/docs/client/rest#messages Layer REST API Documentation about messages
  # @see Layer::Content Sending rich content using Layer::Content
  #
  # @!macro various-apis
  class Message < Resource
    include Operations::Find
    include Operations::Delete
    include Operations::Destroy

    # @!parse extend Layer::Operations::Find::ClassMethods

    # Returns the conversation this message belongs to
    #
    # @return [Layer::Conversation] the message's conversation
    def conversation
      Conversation.from_response(attributes['conversation'], client)
    end

    # Returns the time the message was sent at
    #
    # @return [Time] the time the message was sent at
    def sent_at
      Time.parse(attributes['sent_at'])
    end

    # Marks the message as read by the current user
    #
    # @!macro rest-api
    def read!
      client.post(receipts_url, { type: 'read' })
    end

    # Marks the message as delivered to the current user
    # @!macro rest-api
    def delivered!
      client.post(receipts_url, { type: 'delivery' })
    end

    # The endpoint to send read and delivered receipts to
    #
    # @return [String] the url of the endpoint
    # @!macro rest-api
    def receipts_url
      attributes['receipts_url'] || "#{url}/receipts"
    end
  end
end
