# README

The program is designed to create, edit and delete expenses. Basic operations can be performed on the index page.
An additional tab has been created to filter the desired expense reports. Hotwire and SASS technologies are used in the project.
In addition, a helper was created for one of the partials and tests were written using Rspec and Capybara.
The app used AJAX.

Things you may want to cover:

* Ruby version

> ruby "3.1.3"

* Rails version

> gem "rails", "~> 7.0.4", ">= 7.0.4.2"

* Setup

> Use `bin/setup` and the `bin/dev` scripts for setup project
> Running the `bin/rails db:seed` command is equivalent to removing all the expanses and loading fixtures as development data.

* Registration

For the simplicity of the decision, when registering, it is not necessary to confirm the account with a message to the mail.
However, it is MANDATORY to specify both the login and email in order to further implement the function of sending the report to other users.

* Sharing of report via email

Since the program is a test, it takes several days of approval from the AWS SES team to allow the use of mail distribution in production,
since in the limited mode it is possible to send messages only to addresses verified by the AWS system.
If you have a verified address, you can send messages.