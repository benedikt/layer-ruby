module Layer
  # Managing block lists is also possible:
  #
  # @example
  #   user = Layer::User.find('user_id')
  #   user.blocks.all # Returns a list of blocks
  #   user.blocks.create({ user_id: 'other_user' }) # Adds the other user to the block list
  #   user.blocks.delete('other_user') # Removes the other user from the block list
  #   user.blocks.all.first.delete # Removes the first entry from the block list
  #
  # @see https://developer.layer.com/docs/platform#block-users Layer Platform API Documentation about block lists
  # @!macro platform-api
  class Block < Resource
    include Operations::Delete

    # @!parse extend Layer::Operations::Delete::ClassMethods

  end
end
