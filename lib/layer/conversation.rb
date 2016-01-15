module Layer
  # @example Creating a new conversation
  #   conversation = Layer::Conversation.create({ participants: ['1', '2'] })
  #
  # @example Finding an existing conversation
  #   conversation = Layer::Conversation.find('CONVERSATION_ID_HERE')
  #
  # @example Updating an existing conversation
  #   conversation = Layer::Conversation.find('CONVERSATION_ID_HERE')
  #   conversation.participants << 3
  #   conversation.metadata[:foo] = 'bar'
  #   conversation.save
  #
  # @see https://developer.layer.com/docs/platform#retrieving-conversations Layer Platform API Documentation about conversations
  # @see https://developer.layer.com/docs/client/rest#conversations Layer REST API Documentation about conversations
  # @!macro various-apis
  class Conversation < Resource
    include Operations::Find
    include Operations::Paginate
    include Operations::Create
    include Operations::Delete
    include Operations::Destroy
    include Operations::Patch

    # @!parse extend Layer::Operations::Find::ClassMethods
    # @!parse extend Layer::Operations::Paginate::ClassMethods
    # @!parse extend Layer::Operations::Create::ClassMethods
    # @!parse extend Layer::Operations::Delete::ClassMethods
    # @!parse extend Layer::Operations::Destroy::ClassMethods

    # Returns the converations messages
    #
    # @return [Layer::RelationProxy] the conversation's messages
    # @!macro various-apis
    def messages
      RelationProxy.new(self, Message, [Operations::Create, Operations::Paginate, Operations::Find, Operations::Delete, Operations::Destroy])
    end

    # Returns the conversations metadata
    #
    # @return [Layer::Patch::Hash] the metadata hash
    def metadata
      attributes['metadata'] ||= {}
      attributes['metadata']
    end

    # Returns the conversations metadata
    #
    # @return [Layer::Patch::Array] the participants array
    def participants
      attributes['participants'] ||= []
      attributes['participants']
    end

    # Whether the conversation is distinct
    #
    # @return [Boolean] whether the conversation is distinct
    def distinct?
      attributes['distinct']
    end

    # Returns the time the conversation was created at
    #
    # @return [Time] the time the conversation was created at
    def created_at
      Time.parse(attributes['created_at'])
    end

  end
end
