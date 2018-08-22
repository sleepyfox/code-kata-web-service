Feature: Authenticate an account

Example: we can authenticate an account with the correct email and password, and we get a token
  Given an active account for Mickey Mouse
  When we GET the path /account/authenticate/mmouse%40disney.com
  And the input is JSON { "password": "minnie" }
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "token"
  And the "token" attribute is a string

Example: we do not authenticate an account with the wrong password
  Given an active account for Mickey Mouse
  When we GET the path /account/authenticate/mmouse%40disney.com
  And the input is JSON { "password": "maxxie" }
  Then we should get a reply with status 401 UNAUTHORIZED

Example: we do not authenticate an account with a incorrect email address
  Given an active account for Mickey Mouse
  When we GET the path /account/authenticate/a%40b.com
  And the input is JSON { "password": "whatevs" }
  Then we should get a reply with status 401 UNAUTHORIZED
