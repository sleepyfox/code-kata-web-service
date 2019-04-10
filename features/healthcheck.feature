Feature: Healthcheck
  As a dashboard
  In order to check that the service is running
  I want to check that the service is running

@healthcheck @mvp
Scenario: the service responds to a status request
  When we GET the path /status
  Then we should get a reply with status 200 OK
  And the reply is a JSON object
  And the "service" attribute is the string "account"
  And the "status" attribute is the string "green"
  And the "version" attribute is the string "1.0.0"
