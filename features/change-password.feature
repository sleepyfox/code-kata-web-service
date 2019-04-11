Feature: Change my password
  As a forgetful analyst
  In order to be able to remember my password
  I want to change it to something more memorable

@change-password @mvp
Scenario: we cannot change a user's password without the correct user credentials
  Given an active account for Mickey Mouse
  And that we are not logged in
  When we try and change the password for user "mmouse%40disney.com" to "death2unbelieverz"
  Then we should get a reply with status 401 UNAUTHORIZED

@change-password @mvp
Scenario: we can change the user's password with the correct user token
  Given an active account for Mickey Mouse
  And that we have logged in as mmouse@disney.com and gotten a token
  When we try and change the password for user "mmouse%40disney.com" to "princess123"
  Then we should get a reply with status 200 OK
  And we should be able to login with the new password "princess123"

@change-password @mvp
Scenario: we can change a user's password with the admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as admin@gower.st and gotten a token
  When we try and change the password for user "mmouse%40disney.com" to "aggretsuku"
  Then we should get a reply with status 200 OK
  And we should be able to login with the new password "aggretsuku"

