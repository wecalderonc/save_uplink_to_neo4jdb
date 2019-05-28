require 'neo4j/active_node'

class Sensor4
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :value, type: String

  has_one :out, :uplink, type: :BELONGS_TO
end
