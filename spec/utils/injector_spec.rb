require 'spec_helper'
require 'rack-contact-us/utils/injector'

class TestObject
  def increment_post(var)
    str = var[0..-2]
    num = var[-1].to_i
    "#{str}#{num+1}"
  end

  def test_method(a, b)
    a = increment_post(a)
    b = increment_post(b)
    [a,b]
  end
end

describe Utils::Injector do

  it "takes the method and params to call" do
    context = { a: 'test1', b: 'test2' }
    expect { Utils::Injector.wrap TestObject.new, :test_method, context }.not_to raise_error
  end
  it "matches context to method parameters" do
    context = { a: 'test1', b: 'test2', c: 'test3' }
    injector = Utils::Injector.wrap TestObject.new, :test_method, context
    expect(injector.parameter_values).to eql(['test1', 'test2'])
  end
  it "calls the wrapped method with new parameters" do
    context = { a: 'test1', b: 'test2' }
    injector = Utils::Injector.wrap TestObject.new, :test_method, context
    expect(injector.call).to eql(['test2', 'test3'])
  end
end
