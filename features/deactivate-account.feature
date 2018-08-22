Feature: Deactivate an account

Example: we cannot deactivate an account without admin credentials
  Given an active account for Mickey Mouse
  When we PUT to the path /account/deactivate/mmouse%40disney.com
  And the input is JSON {}
  Then we should get a reply with status 401 UNAUTHORIZED
  And the account should still be active

Example: we can deactivate an account with admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as admin and gotten a token
  When we PUT to the path /account/deactivate/mmouse%40disney.com
  And the input is JSON { "token": "${token}" }
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the reply has an attribute "account-id"
  And the "email" attribute is the string "mmouse@disney.com"
  And the "organisation" attribute is the string "Disney, Inc."
  And the "active" attribute is false

Example: a deactivated account cannot authenticate
  Given a deactivated account for Mickey Mouse
  When we GET the path /account/authenticate/mmouse%40disney.com
  And the input is JSON { "password": "minnie" }
  Then we should get a reply with status 401 UNAUTHORIZED

Example: a deactivated account cannot change their password
  Given a deactivated account for Mickey Mouse
  When we PUT to the path /account/change_password/mmouse%40disney.com
  And the input is JSON { "token": "whatevs", "new-password": "death2unbelieverz" }
  Then we should get a reply with status 401 UNAUTHORIZED
