var exports, mysql, _action;

mysql = require('mysql');

_action = function(input) {
  var output;
  output = input;
  return output;
};

exports = module.exports = function(config) {
  console.log(config);
  return function(req, res, next) {
    var connection;
    connection = mysql.createConnection({
      host: config.host,
      port: config.port,
      user: config.user,
      password: config.password
    });
    connection.config.queryFormat = function(query, values) {
      if (!values) {
        return query;
      }
      return query.replace(/\:(\w+)/g, (function(txt, key) {
        if (values.hasOwnProperty(key)) {
          return this.escape(values[key]);
        }
        return txt;
      }).bind(this));
    };
    if (config.flag) {
      console.log("Has config.flag");
    }
    req.mysqlHero = {
      reconnect: function(options) {
        connection.end();
        return connection.connect(options);
      },
      connect: connection.connect,
      query: connection.query,
      end: connection.end
    };
    next();
  };
};
