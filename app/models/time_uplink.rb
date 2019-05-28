require 'neo4j/active_node'

class TimeUplink
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :value, type: String

  has_one :out, :uplink, type: :BELONGS_TO
end
