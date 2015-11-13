module Layer
  class Message < Resource
    include Operations::Find

    def conversation
      Conversation.from_response(attributes['conversation'], client)
    end

    def sent_at
      Time.parse(attributes['sent_at'])
    end

    def read!
      client.post(receipts_url, { type: 'read' })
    end

    def delivered!
      client.post(receipts_url, { type: 'delivery' })
    end

    def receipts_url
      attributes['receipts_url'] || "#{url}/receipts"
    end
  end
end
