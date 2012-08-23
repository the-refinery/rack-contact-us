require 'pony'

module ContactUs
  class MailSender
    def call(params)
      Pony.mail(params)
    end
  end
end
