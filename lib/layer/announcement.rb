module Layer
  # @example
  #   Layer::Announcement.create({ recipients: 'everyone', sender: { name: 'Server' }, parts: [{ body: 'Hello!', mime_type: 'text/plain' }]})
  #
  # @see https://developer.layer.com/docs/platform#send-an-announcement Layer Platform API Documentation about announcements
  # @!macro platform-api
  class Announcement < Resource
    include Operations::Create

    # @!parse extend Layer::Operations::Create::ClassMethods

    def sent_at
      Time.parse(attributes['sent_at'])
    end

  end
end
