# Web service kata

The objective of this code kata is to produce a simple REST web-service, that has durable persistance. For our purposes we will produce an account service. The account service is used to manage customer accounts. A single 'admin' account is pre-populated that allows special functionality.

## Functions of the account service

* Store the details of a new account (email, password, organisation (optional))
  - also creates a unique account ID and password salt
* Look up the details of an account by account ID
* Look up the details of an account by email address
* Authenticate an account by providing an email address and password
* Allow an authenticated customer to change their password
* Allow an admin to change a customer's password
* Disable an account (reversible, admins only)
* Re-enable a disabled account (admins only)
* Delete an account (irreversible, admins only)

## Constraints

* The service must be durable to restarts i.e. although it is free to cache data, upon being restarted it must not lose the account information
* The passwords must not be stored in plaintext
* Clients of the service do not need to be authenticated themselves, i.e. the service is stateless and no session management is required
* All communication is JSON over HTTP

## Tests

### Healthcheck

TEST that the service responds to a status request
WHEN we GET the path /status
INPUT {}
THEN we should get a reply with
STATUS 200 OK
JSON { "service": "account", "status": "green", "version": "1.0.0" }

### Create a new account

TEST that the service can store a new account
WHEN we POST to the path /account
INPUT { "email": "mmouse@disney.com", "password": "minnie", "organisation": "Disney, Inc." }
THEN a new account is created
STATUS 201 CREATED
JSON { "account_id": __, "email": "mmouse@disney.com", "organisation": "Disney, Inc.", "active": true }

### Retrieving accounts

TEST that we can retrieve the account by email address
WHEN we GET the path /account/mmouse%40disney.com
INPUT {}
THEN the correct account is returned
STATUS 200 OK
JSON { "account_id": __, "email": "mmouse@disney.com", "organisation": "Disney, Inc.", "active": true }

TEST that we can retrieve the account by account ID
WHEN we GET the path /account/mmouse%40disney.com
INPUT {}
THEN the correct account is returned
STATUS 200 OK
JSON { "account_id": __, "email": "mmouse@disney.com", "organisation": "Disney, Inc.", "active": true }

### Authenticating accounts

TEST that we can authenticate an account with the correct email and password, and we get a token
WHEN we GET the path /account/authenticate/mmouse%40disney.com
INPUT { "password": "minnie" }
THEN a token is returned
STATUS 200 OK
JSON { "token": __ }

TEST that we do not authenticate an account with the wrong password
WHEN we GET the path /account/authenticate/mmouse%40disney.com
INPUT { "password": "maxxie" }
THEN a token is not returned
STATUS 401 UNAUTHORIZED
JSON {}

TEST that we do not authenticate an account with a incorrect email address
WHEN we GET the path /account/authenticate/a%40b.com
INPUT { "password": "whatevs" }
THEN a token is not returned
STATUS 401 UNAUTHORIZED
JSON {}

### Changing passwords

TEST that we cannot change a user's password without the correct user credentials
WHEN we PUT to the path /account/change_password/mmouse%40disney.com
INPUT { "token": "whatevs", "new-password": "death2unbelieverz" }
TEST that we can change a user's password with the correct user credentials
STATUS 401 UNAUTHORIZED
JSON {}

TEST that we can change the user's password with the correct user token
GIVEN that we have logged in as mmouse and gotten a token
WHEN we PUT to the path /account/change_password/mmouse%40disney.com
INPUT { "token": "${token}", "new-password": "princess123" }
TEST that we can change a user's password with the correct user credentials
STATUS 200 OK
JSON {}

TEST that we can change a user's password with the admin credentials
GIVEN that we have logged in as admin and gotten a token
WHEN we PUT to the path /account/change_password/mmouse%40disney.com
INPUT { "token": "${token}", "new-password": "aggretsuku" }
TEST that we can change a user's password with the correct admin credentials
STATUS 200 OK
JSON {}

### Deactivate an account

TEST that we cannot deactivate an account without admin credentials
WHEN we PUT to the path /account/deactivate/mmouse%40disney.com
INPUT {}
THEN the account is NOT deactivated
STATUS 401 UNAUTHORIZED
JSON {}

TEST that we can deactivate an account with admin credentials
GIVEN that we have logged in as admin and gotten a token
WHEN we PUT to the path /account/deactivate/mmouse%40disney.com
INPUT { "token": "${token}" }
THEN the account is deactivated
STATUS 200 OK
JSON { "account_id": __, "email": "mmouse@disney.com", "organisation": "Disney, Inc.", "active": false }

TEST that a deactivated account cannot authenticate

TEST that a deactivated account cannot change their password

### Reactivate an account

TEST that we cannot reactivate an account without admin credentials

TEST that we can reactivate an account with admin credentials

### Delete an account (GDPR)

TEST that we cannot delete an account without admin credentials
WHEN we DELETE the path /account/mmouse%40disney.com
INPUT { "token": "master blaster" }
THEN the account is not removed
STATUS 401 UNAUTHORIZED
JSON {}

TEST that we can delete an account with admin credentials
WHEN we DELETE the path /account/mmouse%40disney.com
INPUT { "token": "horcrux" }
THEN the account is removed
STATUS 204 NO CONTENT
JSON {}

TEST that trying to login to a deleted account fails to authenticate
