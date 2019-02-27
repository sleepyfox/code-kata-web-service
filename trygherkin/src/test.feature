Scenario: create a new product

When I create a new product with name 'iphone 6' and description 'snapple phone'
Then I receive a response with an id 42 and a location URL

# this a second comment
# on two lines
When I invoke a GET request on location URL
Then I receive a 200 response
