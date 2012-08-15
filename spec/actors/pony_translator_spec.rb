require 'spec_helper'
require 'rack-contact-us/actors/pony_translator'

describe ContactUs::PonyTranslator do

  let(:actor) { ContactUs::PonyTranslator.new }

  it "translates smtp config into via options" do
    smtp_config = { address: 'localhost' }
    config = actor.translate_via_config smtp: smtp_config
    expect(config).to have_key(:via)
    expect(config[:via]).to eql(:smtp)
    expect(config).to have_key(:via_options)
    expect(config[:via_options]).to eql(smtp_config)
  end
  it "does nothing if no via options are specified" do
    config = actor.translate_via_config({ blah: 'diddy' })
    expect(config).to eql({})
  end
  it "translates sendmail config into via options" do
    sendmail_config = { location: '/path/to/sendmail' }
    config = actor.translate_via_config sendmail: sendmail_config
    expect(config).to have_key(:via)
    expect(config[:via]).to eql(:sendmail)
    expect(config).to have_key(:via_options)
    expect(config[:via_options]).to eql(sendmail_config)

  end
  it "translates html_template into html_body" do
    config = actor.translate_body_config html_template: "I am the html template"
    expect(config).to_not have_key(:html_template)
    expect(config).to have_key(:html_body)
    expect(config[:html_body]).to eql("I am the html template")
  end
  it "translates text_template into body" do
    config = actor.translate_body_config text_template: "I am the text template"
    expect(config).to_not have_key(:text_template)
    expect(config).to have_key(:body)
    expect(config[:body]).to eql("I am the text template")
  end
  it "translates ALL THE THINGS" do
    via_config = { address: 'localhost' }
    html_template = "The html template"
    text_template = "The text template"
    config = actor.call smtp: via_config, html_template: html_template, text_template: text_template, some_option: "PRESENT"
    expect(config).to_not have_key(:text_template)
    expect(config).to_not have_key(:html_template)
    expect(config).to_not have_key(:smtp)
    expect(config[:via]).to eql(:smtp)
    expect(config[:via_options]).to eql(via_config)
    expect(config[:body]).to eql(text_template)
    expect(config[:html_body]).to eql(html_template)
    expect(config[:some_option]).to eql("PRESENT")
  end
end
