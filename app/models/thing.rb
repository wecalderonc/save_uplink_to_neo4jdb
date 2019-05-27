
require 'neo4j/active_node'

#Model Thing
class Thing
  include Neo4j::ActiveNode
  id_property :neo_id
  property :name, type: String
  property :time, type: String

end
