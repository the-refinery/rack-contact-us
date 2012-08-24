# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack-contact-us/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Fiorini", "Benjamin W. Smith"]
  gem.email         = ["joe@joefiorini.com", "benjaminwarfield@just-another.net"]
  gem.description   = %q{Have you ever created a static site but wanted users to be able to fill out a form and email you? How about being able to customize the email that get
s sent with user-submitted values? Or forwarding headers from the HTTP request to SMTP? rack-contact-us allows you to do all of this.}
  gem.summary       = %q{Flexible service to handle contact forms on your static sites.}
  gem.homepage      = "https://github.com/d-i/rack-contact-us"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-contact-us"
  gem.require_paths = ["lib"]
  gem.version       = ContactUs::VERSION
end

