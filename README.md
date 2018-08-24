# Web service kata

The objective of this code kata is to produce a simple REST web-service, that has durable persistance. For our purposes we will produce an account service. The account service is used to manage customer accounts. A single 'admin' account is pre-populated that allows special functionality.

## Functions of the account service

1. Store the details of a new account (email, password, organisation (optional))
  - also creates a unique account ID and password salt
  - Only an admin can create a new user
2. Retrieve customer details
  - Look up the details of an account by email address
  - Look up the details of an account by account ID
  - Both return account ID, email, organisation and active status
3. Authenticate an account by providing an email address and password
4. Change password
  - Allow an authenticated customer to change their password
  - Allow an admin to change a customer's password
5. Disable an account (reversible, admins only)
  - A disabled account cannot authenticate
6. Re-enable a disabled account (admins only)
  - A re-enabled account is the same as an ordinary enabled account
7. Delete an account (irreversible, admins only)
  - A deleted account cannot authenticate, and is not returned in lookups

Stories 1-3 should be considered a Minimum Viable Product (MVP). Stories 4-7 should be considered as desirable, but not necessary for launch.

## Constraints

* The service must be durable to restarts i.e. although it is free to cache data, upon being restarted it must not lose the account information
* The passwords must not be stored in plaintext
* Clients of the service do not need to be authenticated themselves, as they are assumed to be within a secure network i.e. the service is stateless and no session management is required
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

An initial implementation of the system tests is provided. Implementation-specific unit tests are expected.
