module Layer
  class SingletonRelationProxy < RelationProxy
    include Operations::Fetch::ClassMethods
    include Operations::Fetch

    def respond_to_missing?(method, include_private = false)
      resource.respond_to?(method, include_private) || super
    end

    def from_response(*args)
      resource_type.from_response(*args)
    end

  private

    def method_missing(method, *args, &block)
      if resource.respond_to?(method)
        resource.public_send(method, *args, &block)
      else
        super
      end
    end

    def resource
      @resource ||= fetch
    end

  end
end
