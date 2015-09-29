module Layer
  class Conversation < Resource
    include Operations::Find
    include Operations::List
    include Operations::Create
    include Operations::Patch

    def messages
      RelationProxy.new(self, Message, [Operations::Create, Operations::List])
    end

    def distinct?
      attributes['distinct']
    end

    def created_at
      Time.parse(attributes['created_at'])
    end

  end
end
