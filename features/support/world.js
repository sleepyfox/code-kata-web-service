var setWorldConstructor = (require("cucumber")).setWorldConstructor;
var customWorld = (function() {
  /* features/support/world.sibilant:4:18 */

  
});
customWorld.prototype.constructor = (function customWorld$prototype$constructor$() {
  /* custom-world.prototype.constructor features/support/world.sibilant:4:25 */

  return this.variable = 0;
});
customWorld.prototype.setTo = (function customWorld$prototype$setTo$(n) {
  /* custom-world.prototype.set-to features/support/world.sibilant:5:0 */

  return this.variable = n;
});
customWorld.prototype.incrementBy = (function customWorld$prototype$incrementBy$(n) {
  /* custom-world.prototype.increment-by features/support/world.sibilant:6:0 */

  return this.variable = (n + this.variable);
});
setWorldConstructor(customWorld);
