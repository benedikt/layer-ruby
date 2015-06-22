module Layer
  class Announcement < Resource
    include Operations::Create

    def sent_at
      Time.parse(attributes['sent_at'])
    end

  end
end

