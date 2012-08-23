module ContactUs
  class App
    def call(env)
      request = Rack::Request.new(env)
      if request.request_method == "POST"
        requested_mailer = request.path.split("/").last
        mailer = ContactUs.mailers.select { |m| m == requested_mailer }.first
        config = ContactUs.mailer_config_at mailer
        director = ContactUs::MailerDirector.new
        director.call config, request.params.merge(headers(request))
      end
      [200, {"Content-Type" => "text/html"}, ["OK"]]
    end

    private

    def headers(request)
      { remote_ip: request.ip, accept: request.accept_encoding }
    end
  end
end
