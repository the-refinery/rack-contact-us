require 'tilt'

class ParameterRenderer
  def initialize(options={})
    @template_class = options.delete(:template_class) || Tilt::LiquidTemplate
  end
  def call(params, context)
    params.reduce({}) do |new_params,(key,value)|
      if value.is_a? Hash
        new_params[key] = call(value, context)
        new_params.tap { |u| puts "new_params: #{new_params.inspect}" }
      else
        template = @template_class.new { value }
        new_params[key] = template.render(nil, context)
        new_params
      end
    end
  end
end
