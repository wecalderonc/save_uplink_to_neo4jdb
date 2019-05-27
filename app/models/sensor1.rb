require 'neo4j/active_node'

#Model Sensor1
class Sensor1
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :value, type: String

end
