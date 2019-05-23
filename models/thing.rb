
require 'neo4j/active_node'

class Thing
  include Neo4j::ActiveNode
  id_property :neo_id
  property :name, type: String
  property :time, type: String

  # has_one :in, :creator, type: :CREATED, model_class: :User
  # has_many :out, :uplinks_created, type: :UPLINK_CREATED, model_class: :Uplink

end
