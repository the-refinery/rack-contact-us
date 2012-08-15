Feature: Send email

  Scenario: Simple mailer
    Given a mailer named "simple-mailer.mailer" exists with:
      | to             | from        |
      | blah@diddy.com | doo@dah.com |
    When I post to "/simple-mailer"
    Then the designated recipient receives an email

  Scenario: Mailer with variable from
    Given a mailer named "variable-mailer.mailer" exists with:
      | to            | from        |
      | doo@diddy.com | {{ email }} |
    When I post to "/variable-mailer" with:
      | name    | email       |
      | Doo Dah | blah@dah.com |
    Then the designated recipient receives an email from "blah@dah.com"

  Scenario: Mailer with custom header
    Given a mailer named "header-mailer.mailer" exists with headers:
      | X-Request-IP    |
      | {{ remote_ip }} |
    When I post to "/header-mailer"
    Then the designated recipient receives an email with headers:
      | X-Request-IP | 127.0.0.1 |
