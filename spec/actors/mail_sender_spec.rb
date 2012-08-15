require 'spec_helper'
require 'rack-contact-us/actors/mail_sender'

describe ContactUs::MailSender do
  it "sends mail through Pony" do
    config = { to: "blah@diddy.doo", from: "doo@dah.com" }
    Pony.should_receive(:mail).with(config)
    ContactUs::MailSender.new.call(config)
  end
end
