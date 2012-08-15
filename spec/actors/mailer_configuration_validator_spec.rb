require 'spec_helper'
require 'rack-contact-us/actors/configuration_validator'

describe ConfigurationValidator do
  context "creating a message" do
    let(:cc) { "cc@diddy.com" }
    let(:bcc) { "bcc@diddy.com" }
    let(:from) { "from@diddy.com" }
    let(:html_body) { "html body" }
    let(:mail_subject) { "subject" }
    let(:charset) { "UTF-8" }
    let(:text_part_charset) { "ASCII" }
    let(:attachments) { ["file object"] }
    let(:message_id) { "12345678" }
    let(:sender) { "sender" }
    let(:reply_to) { "ME" }
    let(:mailer) do
      ConfigurationValidator.new to: "blah@diddy.com",
               body: "this is the body",
               headers: { "List-ID" => "12345" },
               via: :smtp,
               via_options: { address: "localhost" },
               cc: cc, bcc: bcc, html_body: html_body,
               subject: mail_subject, charset: charset,
               text_part_charset: text_part_charset, from: from,
               attachments: attachments, message_id: message_id,
               sender: sender, reply_to: reply_to
    end
    subject { mailer }

    its(:to) { should eq("blah@diddy.com") }
    its(:body) { should eq("this is the body") }
    its(:via) { should eq(:smtp) }
    its(:via_options) { should eq(address: "localhost") }
    its(:cc) { should eq(cc) }
    its(:from) { should eq(from) }
    its(:html_body) { should eq(html_body) }
    its(:subject) { should eq(mail_subject) }
    its(:charset) { should eq(charset) }
    its(:text_part_charset) { should eq(text_part_charset) }
    its(:attachments) { should eq(attachments) }
    its(:message_id) { should eq(message_id) }
    its(:sender) { should eq(sender) }
    its(:reply_to) { should eq(reply_to) }
    its(:headers) { should eq({ 'List-ID' => '12345' }) }

  end
end

