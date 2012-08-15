require 'spec_helper'
require 'rack-contact-us/actors/configuration_reader'

describe ContactUs::ConfigurationReader do

  it "parses YAML" do
    config = ContactUs::ConfigurationReader.new.call("blah: diddy")
    expect(config).to eql(blah: "diddy")
  end
end
