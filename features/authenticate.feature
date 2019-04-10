Feature: Authenticate an account
  As a user
  In order to use the system
  I want to log in

@authenticate
Scenario: we can authenticate an account with the correct email and password, and we get a token
  Given an active account for Mickey Mouse
  When we send JSON { "password": "minnie" } with a GET to the path /account/authenticate/mmouse%40disney.com
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "token"
  And the "token" attribute is a string

@authenticate
Scenario: we do not authenticate an account with the wrong password
  Given an active account for Mickey Mouse
  When we send JSON { "password": "maxxie" } with a GET to the path /account/authenticate/mmouse%40disney.com
  Then we should get a reply with status 401 UNAUTHORIZED

@authenticate
Scenario: we do not authenticate an account with a incorrect email address
  Given an active account for Mickey Mouse
  When we send JSON { "password": "whatevs" } with a GET to the path /account/authenticate/a%40b.com
  Then we should get a reply with status 401 UNAUTHORIZED
