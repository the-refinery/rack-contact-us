require_relative './actors/configuration_reader'
require_relative './actors/configuration_validator'
require_relative './actors/mail_sender'
require_relative './actors/parameter_renderer'
require_relative './actors/pony_translator'
require_relative './mailer_director'
require_relative './app'

module ContactUs

  def self.mailer_dir
    File.expand_path("mailers")
  end

  def self.mailers
    Dir["#{mailer_dir}/**/*.mailer"].map do |path|
      File.basename(path, ".mailer")
    end
  end

  def self.mailer_config_at(mailer)
    File.read(File.join(mailer_dir, "#{mailer}.mailer"))
  end

  def self.mount_at!(path, builder=Rack::Builder.new)
    builder.map path do
      run ContactUs::App.new
    end
  end


end
