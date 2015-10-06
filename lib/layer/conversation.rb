module Layer
  class Conversation < Resource
    include Operations::Find
    include Operations::List
    include Operations::Create
    include Operations::Delete
    include Operations::Patch

    def self.destroy(id, client = self.client)
      id = Layer::Client.normalize_id(id)
      client.delete("#{url}/#{id}", {}, { params: { destroy: true } })
    end

    def messages
      RelationProxy.new(self, Message, [Operations::Create, Operations::List])
    end

    def distinct?
      attributes['distinct']
    end

    def created_at
      Time.parse(attributes['created_at'])
    end

    def destroy
      client.delete(url, {}, { params: { destroy: true } })
    end

  end
end
