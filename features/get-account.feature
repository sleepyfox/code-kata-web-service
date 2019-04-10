Feature: get account
  As a proxy
  In order to see information about a user
  I want to see information about a user

@get-account @mvp
Scenario: we can retrieve the account by email address
  Given that we have logged in as admin@gower.st and gotten a token
  And an active account for Mickey Mouse
  When we GET the path /account/mmouse%40disney.com
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "company_id" attribute is the number 99
  And the "active" attribute is true

@get-account @skip
Scenario: we can retrieve the account by account ID
  Given an active account for Mickey Mouse
  When we GET the path /account/99
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "company_id" attribute is the number 99
  And the "active" attribute is true
