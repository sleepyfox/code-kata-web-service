Feature: Create a new account

@create-account @mvp
Scenario: the service can store a new account
  Given that we have logged in as admin@gower.st and gotten a token
  When we POST an account to the path /account/mmouse@disney.com
  Then we should get a reply with status 201 CREATED
  And the reply is a JSON object
  And the reply has an attribute "id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "companyid" attribute is the number 99
  And the "active" attribute is true

@create-account @mvp
Scenario: a non-admin user cannot create an account
  Given an active account for Mickey Mouse
  And that we have logged in as mmouse@disney.com and gotten a token
  When we POST an account to the path /account/dduck@disney.com
  Then we should get a reply with status 401 UNAUTHORIZED

@create-account @mvp
Scenario: an unauthenticated user cannot create an account
  When we POST an account to the path /account/mmouse@disney.com
  Then we should get a reply with status 401 UNAUTHORIZED
