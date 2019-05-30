require 'neo4j/active_node'

class Thing
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :name, type: String

  validates :name, presence: true

  has_many :out, :uplinks_created, type: :UPLINK_CREATED, model_class: :Uplink
end
