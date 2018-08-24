Feature: Create a new account

Example: the service can store a new account
  Given that we have logged in as admin and gotten a token
  When we POST to the path /account
  And the input is JSON { "token": "${self.token}", "email": "mmouse@disney.com", "password": "minnie", "organisation": "Disney, Inc." }
  Then we should get a reply with status 201 CREATED
  And the reply is a JSON object
  And the reply has an attribute "account-id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "organisation" attribute is the string "Disney, Inc."
  And the "active" attribute is true
