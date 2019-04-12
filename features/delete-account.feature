Feature: Delete an account (GDPR)

@delete @mvp
Scenario: we cannot delete an account without admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as mmouse@disney.com and gotten a token
  When we DELETE to the path /account/mmouse@disney.com with the correct token
  Then we should get a reply with status 401 UNAUTHORIZED

@delete @mvp
Scenario: we can delete an account with admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as admin@gower.st and gotten a token
  When we DELETE to the path /account/mmouse@disney.com with the correct token
  Then we should get a reply with status 204 NO CONTENT
  And we cannot login with our usual credentials

@delete @mvp @skip
Scenario: trying to login to a deleted account fails to authenticate
  Given that there is no account for mmouse@disney.com
  When we GET the path /account/authenticate/mmouse@disney.com
  Then we should get a reply with status 401 UNAUTHORIZED
