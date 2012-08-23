# Getting Started

## What is this?

Have you ever created a static site but wanted users to be able to fill out a form and email you? How about being able to customize the email that gets sent with user-submitted values? Or forwarding headers from the HTTP request to SMTP? rack-contact-us allows you to do all of this. Here's how it works.

### Mailers

Mailers are simple YAML files that live in a `mailers` directory in the root of the app. Using YAML key-value pairs, they specify parameters that get passed on to the [Pony, an email sending library for Ruby](https://github.com/benprew/pony). In addition to Pony parameters, you can also configure templates for HTML and text emails, but more on that in a minute. The URI endpoint for a mailer is simply the name of the mailer file without the `.yaml` extension.

### HTML Forms

When you create your HTML form, all it needs to do is POST to your mailer's URI endpoint (see above). From there, any form parameters are sent to the mailer and accessible using the [Liquid templating engine](https://github.com/shopify/liquid) (see example below).

## Install

rack-contact-us is hosted on rubygems.org. Install it with `gem install rack-contact-us`. It is a Rack endpoint, but mounting it depends on [the framework](http://guides.rubyonrails.org/rails_on_rack.html) [you are](http://rubydoc.info/gems/sinatra#Rack_Middleware) [developing on](http://middlemanapp.com/advanced/rack-middleware/). In a pure Rack app you probably already have a `Rack::Builder` instance, so in your `config.ru` just use:

```ruby
ContactUs.mount_at! "/contact", self
```

## Create a mailer

1. Create directory called `mailers` in the root of the repoistory.
2. Under mailers create a file named `contact-us.mailer`.
3. Add any parameters supported by Pony here (see https://github.com/benprew/pony) - this is just a YAML file

- N.B. To specify `body` or `body_html` use `template_text` or `template_html` parameters respectively.

For example:

    to: 'youremail@example.com'
    from: '{{ email }}'
    template_text: >

      {{ message }}

      - {{ name }} <{{ email }}>

## Test it

Rackup the site and post to the mailer to send an email

    curl -d "greeting=Hello%20there&name=Cool%20Guy&email=coolguy@example.com" http://localhost:9292/contact/contact-us

Now design your form and have it post to your mailer:

```html
<form method="post" action="http://localhost:9292/contact/contact-us">
  <label>
    Your name:
    <input type="text" name="name" id="name" placeholder="Bob Example">
  </label>
  <label>
    Email:
    <input type="text" name="email" id="email" placeholder="bob@example.com">
  </label>
  <label>
    Message:
    <textarea name="message" id="message"></textarea>
  </label>
</form>
```

## Development

- Run `bundle install` (and `gem install bundler` if you don't have it already) to install dependencies
- Run the tests with `rake test`
- Fire up the server with `rackup config.ru`

## Contributing

If you think you've run into a bug or want to add a feature, first please check out our [issues page](https://github.com/d-i/rack-contact-us/issues). That is where we'll keep the features we want to attack soon. If no one has submitted the feature you want already, feel free to fork and send us a pull request with your changes. Before we accept the request, please be sure:

1. Your work is done in a topic branch that is rebased on top of the latest master
2. You have test coverage for any significant changes (at the very least Cucumber if it's a new feature)
3. If it's a bug fix, please include a passing Cucumber scenario that details the proper behavior
