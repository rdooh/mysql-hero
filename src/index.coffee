#======================================
# !Require modules
#======================================
mysql = require 'mysql'
#======================================
# End Require modules
#======================================




#======================================
# !Private methods
#======================================
_action = (input)->
  output = input
  return output
#======================================
# End Private methods
#======================================




#======================================
# !Main module
#======================================
exports = module.exports = (config)->
  # !Logic to run at config time
  console.log config
  # !Method that will run every time this module is 'used' by Express
  return (req, res, next) ->
    # !Logic to run when used
    
    # !Define connection with the database using original config params
    connection = mysql.createConnection
      host: config.host
      port: config.port
      user: config.user
      password: config.password
    
    # !Define Query format to accept ':var' in the query, and {var:value} in second arg
    # - this basically goes escaping - not true prepare, I believe
    connection.config.queryFormat = (query, values) ->
      return query  unless values
      query.replace /\:(\w+)/g, ((txt, key) ->
        return @escape(values[key])  if values.hasOwnProperty(key)
        txt
      ).bind(this)
    
    
    console.log "Has config.flag" if config.flag
    
    # !Modifications to 'req' object - adding module-related object
    req.mysqlHero =
      reconnect: 
    
      # Map basic methods
      connect: connection.connect
      query: connection.query
      end: connection.end
      
      # Add convenience methods
      
      

    # !Modifications to 'res' object - adding module-related object
    # res.mysqlHero =
    # data: 'stuff'
      
    # !Call the next method in the chain
    next()    
    return


#======================================
# End Main module
#======================================





