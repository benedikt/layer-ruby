module Layer
  class Webhook < Resource
    include Operations::Find
    include Operations::List
    include Operations::Create
    include Operations::Delete

    # @!parse extend Layer::Operations::Find::ClassMethods
    # @!parse extend Layer::Operations::List::ClassMethods
    # @!parse extend Layer::Operations::Create::ClassMethods
    # @!parse extend Layer::Operations::Delete::ClassMethods

    def activate!
      client.post("#{url}/activate")
    end

    def deactivate!
      client.post("#{url}/deactivate")
    end

    def unverified?
      status == 'unverified'
    end

    def active?
      status == 'active'
    end

    def inactive?
      status == 'inactive'
    end

    def created_at
      Time.parse(attributes['created_at'])
    end

  end
end
