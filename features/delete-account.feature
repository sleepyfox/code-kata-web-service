Feature: Delete an account (GDPR)

Example: we cannot delete an account without admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as mmouse and gotten a token
  When we DELETE to the path /account/mmouse%40disney.com
  And the input is JSON { "token": "${self.token}" }
  Then we should get a reply with status 401 UNAUTHORIZED

Example: we can delete an account with admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as admin and gotten a token
  When we DELETE to the path /account/mmouse%40disney.com
  And the input is JSON { "token": "${self.token}" }
  Then we should get a reply with status 204 NO CONTENT
  And we cannot login with our usual credentials

Example: trying to login to a deleted account fails to authenticate
  Given Mickey Mouse's account has been deleted
  When we GET the path /account/authenticate/mmouse%40disney.com
  And the input is JSON { "password": "minnie" }
  Then we should get a reply with status 401 UNAUTHORIZED
