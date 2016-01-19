require 'layer/patch/base'
require 'layer/patch/array'
require 'layer/patch/hash'

module Layer
  class Patch
    def initialize(property = nil, parent = nil)
      @property = property
      @parent = parent
    end

    def add(property = nil, value)
      operation(:add, property, value: value)
    end

    def add_index(property = nil, index, value)
      operation(:add, property, index: index, value: value)
    end

    def remove(property = nil, value)
      operation(:remove, property, value: value)
    end

    def remove_index(property = nil, index)
      operation(:remove, property, index: index)
    end

    def set(property = nil, value)
      operation(:set, property, value: value)
    end

    def replace(property = nil, value)
      operation(:replace, property, value: value)
    end

    def delete(property)
      operation(:delete, property)
    end

    def nested(property)
      self.class.new(property, self)
    end

    def operations
      @operations ||= @parent ? @parent.operations : []
    end

    def reset
      @parent ? parent.reset : operations.clear
    end

    attr_reader :property

  private

    def operation(type, property = nil, options = {})
      operations << options.merge(operation: type.to_s, property: expand_property(property))
    end

    def expand_property(property)
      [@parent && @parent.property, @property, property].compact.join('.')
    end
  end
end
