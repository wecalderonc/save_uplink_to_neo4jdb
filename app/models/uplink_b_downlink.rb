require 'neo4j/active_node'

class UplinkBDownlink
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :value, type: String

  validates :value, presence: true

  has_one :out, :uplink, type: :BELONGS_TO
end
