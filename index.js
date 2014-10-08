var exports, thing, _action;

thing = require('thing');

_action = function(input) {
  var output;
  output = input;
  return output;
};

exports = module.exports = function(config) {
  console.log(config);
  return function(req, res, next) {
    if (config.flag) {
      console.log("Has config.flag");
    }
    req.myHero = {
      store: function(data) {
        res.myHero.data = data;
      }
    };
    res.myHero = {
      data: 'stuff'
    };
    next();
  };
};
