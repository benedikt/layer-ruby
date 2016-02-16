module Layer
  # @example
  #   webhook = Layer::Webhook.create({
  #     version: '1.0',
  #     target_url: 'https://example.com/layer/webhook',
  #     events: ['message.sent'],
  #     secret: 'my-secret',
  #     config: { foo: :bar }
  #   })
  # @see https://developer.layer.com/docs/webhooks/introduction
  #
  # @!macro platform-api
  class Webhook < Resource
    include Operations::Find
    include Operations::List
    include Operations::Create
    include Operations::Delete

    # @!parse extend Layer::Operations::Find::ClassMethods
    # @!parse extend Layer::Operations::List::ClassMethods
    # @!parse extend Layer::Operations::Create::ClassMethods
    # @!parse extend Layer::Operations::Delete::ClassMethods

    def self.client
      @client ||= Client::Webhook.new
    end

    # Activate this webhook
    def activate!
      client.post("#{url}/activate")
    end

    # Deactivate this webhook
    def deactivate!
      client.post("#{url}/deactivate")
    end

    # Check if this webhook is unverified
    # @return [Boolean] whether the webhook is unverified
    def unverified?
      status == 'unverified'
    end

    # Check if this webhook is active
    # @return [Boolean] whether the webhook is active
    def active?
      status == 'active'
    end

    # Check if this webhook is inactive
    # @return [Boolean] whether the webhook is inactive
    def inactive?
      status == 'inactive'
    end

    # Returns the time the webhook was created at
    # @return [Time] the time the webhook was created at
    def created_at
      Time.parse(attributes['created_at'])
    end

  end
end
