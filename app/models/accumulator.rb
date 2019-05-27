require 'neo4j/active_node'

#Model Accumulator
class Accumulator
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :value, type: String

end
