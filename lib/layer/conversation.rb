module Layer
  class Conversation < Resource
    include Operations::Find
    include Operations::Create

    def distinct?
      attributes['distinct']
    end

    def created_at
      Time.parse(attributes['created_at'])
    end

  end
end
