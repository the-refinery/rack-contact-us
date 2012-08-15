module Utils
  class Injector
    attr_reader :object, :method, :context

    def self.wrap(object, method, context)
      new object, method, context
    end

    def initialize(object, method, context)
      @object = object
      @method = method
      @context = context
    end

    def parameter_values
      method_parameter_names.map do |name|
        @context[name]
      end
    end

    def call
      object.send method, *parameter_values
    end

    private

    def method_info
      object.method method
    end

    def method_parameter_names
      method_info.parameters.map do |param|
        param.last
      end
    end

  end
end
