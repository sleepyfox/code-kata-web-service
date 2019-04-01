var cucumber$1 = require("cucumber"),
    Given = cucumber$1.Given,
    When = cucumber$1.When,
    Then = cucumber$1.Then,
    cucumber$1 = undefined,
    assert = require("assert");
Given("a variable set to {int}", (function(number) {
  /* features/support/steps.sibilant:5:33 */

  return this.setTo(number);
}));
When("I increment the variable by {int}", (function(number) {
  /* features/support/steps.sibilant:7:42 */

  return this.incrementBy(number);
}));
Then("the variable should contain {int}", (function(number) {
  /* features/support/steps.sibilant:9:42 */

  return assert.equal(this.variable, number);
}));
