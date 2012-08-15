# Getting Started

## Create a mailer

1. Create directory called `mailers` in the root of the repoistory.
2. Under mailers create a file named `contact-us.mailer`.
3. Add any parameters supported by Pony here - this is just a YAML file (see https://github.com/benprew/pony)

- N.B. To specify `body` or `body_html` use `template_text` or `template_html` parameters respectively.

For example:

    to: 'youremail@example.com'
    from: '{{ email }}'
    template_text: >
      {{ greeting }},

      {{ message }}

      - {{ name }} <{{ email }}>

## Test it

it: Rackup the site and post to the mailer to send an email

    curl -d "greeting=Hello%20there&name=Cool%20Guy&email=coolguy@example.com" http://localhost:9292/contact/contact-us

