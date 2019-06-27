require 'neo4j/active_node'

class BaseModel
  include Neo4j::ActiveNode
  include Neo4j::Timestamps
end
