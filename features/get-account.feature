Feature: get account
  As a proxy
  In order to see information about a user
  I want to see information about a user
  
Scenario: we can retrieve the account by email address
  Given an active account for Mickey Mouse
  When we GET the path /account/mmouse%40disney.com
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "account_id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "organisation" attribute is the string "Disney, Inc."
  And the "active" attribute is true

Scenario: we can retrieve the account by account ID
  Given an active account for Mickey Mouse
  When we GET the path /account/mmouse%40disney.com
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "account_id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "organisation" attribute is the string "Disney, Inc."
  And the "active" attribute is true
