Feature: Change my password

Example: we cannot change a user's password without the correct user credentials
  Given an active account for Mickey Mouse
  When we PUT to the path /account/change_password/mmouse%40disney.com
  And the input is JSON { "token": "whatevs", "new-password": "death2unbelieverz" }
  Then we should get a reply with status 401 UNAUTHORIZED

Example: we can change the user's password with the correct user token
  Given an active account for Mickey Mouse
  And that we have logged in as mmouse and gotten a token
  When we PUT to the path /account/change_password/mmouse%40disney.com
  And the input is JSON { "token": "${self.token}", "new-password": "princess123" }
  Then we should get a reply with status 200 OK
  And we should be able to login with the new password "princess123"

Example: we can change a user's password with the admin credentials
  Given an active account for Mickey Mouse
  And that we have logged in as admin and gotten a token
  When we PUT to the path /account/change_password/mmouse%40disney.com
  And the input is JSON { "token": "${self.token}", "new-password": "aggretsuku" }
  Then we should get a reply with a status 200 OK
  And we should be able to login with the new password "aggretsuku"

