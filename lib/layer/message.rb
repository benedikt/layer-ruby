module Layer
  class Message < Resource

    def conversation
      Conversation.from_response(attributes['conversation'], client)
    end

    def sent_at
      Time.parse(attributes['sent_at'])
    end

  end
end
