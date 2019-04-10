app = require('express')()
bodyParser = require('body-parser')

PORT = 8080

process.on 'SIGINT', -> process.exit 1
process.on 'uncaughtException', (e) -> console.log e

app
  .use bodyParser.json()
  .get '/status', (req, res) ->
    console.log "Healthcheck requested"
    res.json
      service: "account"
      status: "green"
      version: "1.0.0"
  .get '/account/authenticate/:user', (req, res) ->
    console.log "Trying to authenticate user #{req.params.user} with password #{req.body.password}"
    if req.body.password is "minnie"
      res.json
        token: "discombobulate"
    else
      res.status(401).end()
  .get '/account/:user', (req, res) ->
    console.log "GET account details for #{req.params.user}"
    res.json
      account_id: "NUID"
      email: "mmouse@disney.com"
      organisation: "Disney, Inc."
      active: true
  .post '/account', (req, res) ->
    console.log "POSTing account #{JSON.stringify(req.body, null, 2)}"
    res.status(201).json
      account_id: "NUID"
      email: "mmouse@disney.com"
      organisation: "Disney, Inc."
      active: true
  .put '/account/change_password/:user', (req, res) ->
    console.log "User #{req.params.user} trying to change password with token #{req.body.token}"
    if req.body.token is "discombobulate"
      res.json
        message: "password changed"
    else
      res.status(401).json
        message: "Request unauthenticated!"
  .listen PORT, (err) ->
    throw err if err
    console.log "Express server running on localhost:#{PORT}"
