$: << File.expand_path("./lib")

require 'rack-contact-us/contact_us'
require 'rack-contact-us/app'

map "/contact" do
  run ContactUs::App.new
end
