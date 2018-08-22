# Web service kata

The objective of this code kata is to produce a simple REST web-service, that has durable persistance. For our purposes we will produce an account service. The account service is used to manage customer accounts. A single 'admin' account is pre-populated that allows special functionality.

## Functions of the account service

* Store the details of a new account (email, password, organisation (optional))
  - also creates a unique account ID and password salt
* Look up the details of an account by account ID
  - Returns account ID, email, organisation and active status
* Look up the details of an account by email address
  - Returns account ID, email, organisation and active status
* Authenticate an account by providing an email address and password
* Allow an authenticated customer to change their password
* Allow an admin to change a customer's password
* Disable an account (reversible, admins only)
  - A disabled account cannot authenticate
* Re-enable a disabled account (admins only)
  - A re-enabled account is the same as an ordinary enabled account
* Delete an account (irreversible, admins only)
  - A deleted account cannot authenticate, and is not returned in lookups

## Constraints

* The service must be durable to restarts i.e. although it is free to cache data, upon being restarted it must not lose the account information
* The passwords must not be stored in plaintext
* Clients of the service do not need to be authenticated themselves, i.e. the service is stateless and no session management is required
* All communication is JSON over HTTP

## Tests

The tests are contained in the following Gherkin feature files:

- [Healthcheck](/features/healthcheck.feature)
- [Create account](/features/create-account.feature)
- [Retrieve account](/features/get-account.feature)
- [Authenticate account](/features/authenticate.feature)
- [Change password](/features/change-password.feature)
- [Deactivate account](/features/deactivate-account.feature)
- [Reactivate account](/features/reactivate-account.feature)
- [Delete account](/features/delete-account.feature)
