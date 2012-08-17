require 'spec_helper'
require 'rack-contact-us/actors/parameter_renderer'

class TestTemplate
  def initialize(&block)
    @template = block.call
  end
  def render(params, context)
    keys = context.keys
    keys.reduce @template do |str,key|
      str.gsub("%#{key}", context[key])
    end
  end
end

describe ParameterRenderer do
  it "uses the specified renderer" do
    params = { to: "%admin" }
    renderer = ParameterRenderer.new template_class: TestTemplate
    result = renderer.call(params, { admin: "blah@diddy.doo" })
    expect(result).to eql(to: "blah@diddy.doo")
  end
  it "renders multiple parameters" do
    params = { to: "%admin", from: "%name" }
    renderer = ParameterRenderer.new template_class: TestTemplate
    result = renderer.call(params, { admin: "blah@diddy.doo", name: "Blah Diddy" })
    expect(result).to eql(to: "blah@diddy.doo", from: "Blah Diddy")
  end
end
