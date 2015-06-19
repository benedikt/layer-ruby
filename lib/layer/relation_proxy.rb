module Layer
  class RelationProxy

    attr_reader :resource_type, :base

    def initialize(base, resource_type, operations = [])
      @resource_type = resource_type
      @base = base

      operations.each { |operation| singleton_class.include(operation::ClassMethods) }
    end

    def url
      "#{base.url}#{resource_type.url}"
    end

    def respond_to_missing?(method, include_private = false)
      resource_type.respond_to?(method, include_private) || super
    end

  private

    def method_missing(method, *args, &block)
      if resource_type.respond_to?(method)
        resource_type.public_send(method, *args, &block)
      else
        super
      end
    end

  end
end
