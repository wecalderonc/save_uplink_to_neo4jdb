
require 'neo4j/active_node'

#Model Uplink
class Uplink
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :name, type: String
  property :data, type: String
  property :avgsnr, type: String
  property :rssi, type: String
  property :long, type: String
  property :lat, type: String
  property :snr, type: String
  property :station, type: String
  property :seqnumber, type: String
  property :time, type: String
  property :sec_uplinks, type: String
  property :sec_downlinks, type: String
end
