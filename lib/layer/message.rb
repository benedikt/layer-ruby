module Layer
  class Message < Resource

    def conversation
      Conversation.from_response(attributes['conversation'], client)
    end

    def sent_at
      Time.parse(attributes['sent_at'])
    end

    def read!
      client.post("#{url}/receipts", { type: 'read' })
    end

    def delivered!
      client.post("#{url}/receipts", { type: 'delivery' })
    end

  end
end
