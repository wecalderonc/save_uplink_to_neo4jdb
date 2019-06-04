require 'neo4j/active_node'

class ApplicationRecord
    include Neo4j::ActiveNode
    include Neo4j::Timestamps
end
  