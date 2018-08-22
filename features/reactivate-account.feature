Feature: Reactivate an account

Example: we cannot reactivate an account without admin credentials
  Given a deactivated account for Mickey Mouse
  When we PUT to the path /account/reactivate/mmouse%40disney.com
  And the input is JSON { "password": "minnie" }
  Then we should get a reply with status 401 UNAUTHORIZED

TEST that we can reactivate an account with admin credentials
  Given a deactivated account for Mickey Mouse
  And that we have logged in as admin and gotten a token
  When we PUT to the path /account/reactivate/mmouse%40disney.com
  And the input is JSON { "token": "${self.token}" }
  Then we should get a reply with a status 200 OK
  And we should be able to login with our existing credentials
