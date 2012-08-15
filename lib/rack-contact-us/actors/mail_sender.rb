require 'pony'

module ContactUs
  class MailSender
    def call(params)
      puts "Sending mail with params: #{params.inspect}"
      Pony.mail(params)
    end
  end
end
