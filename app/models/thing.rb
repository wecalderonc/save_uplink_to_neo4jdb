
require 'neo4j/active_node'

#Model Thing
class Thing
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :name, type: String
end
