require 'bundler/setup'
Bundler.require :test, :default

require 'rack-contact-us'
require 'rack/test'

require 'email_spec/cucumber'
require 'capybara/cucumber'


Capybara.app = ContactUs::App.new

module Blah
  def app
    Capybara.app
  end
end

Before do
  FakeFS.activate!
end

After do
  FakeFS::FileSystem.clear
  FakeFS.deactivate!
end

World(Rack::Test::Methods)
World(Rspec::Matchers)
World(Capybara::DSL)
World(Blah)
