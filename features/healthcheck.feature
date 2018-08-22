Feature: Healthcheck

Example: the service responds to a status request
  When we GET the path /status
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the service is the string "account"
  And the status is the string "green"
  And the version is the string "1.0.0"
