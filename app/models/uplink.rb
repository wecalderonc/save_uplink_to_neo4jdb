
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

  has_one :in, :uplinks_created, type: :UPLINK_CREATED, model_class: :Thing

  has_one :in, :Accumulator, type: :BELONGS_TO
  has_one :in, :Alarm, type: :BELONGS_TO
  has_one :in, :Sensor1, type: :BELONGS_TO
  has_one :in, :Sensor2, type: :BELONGS_TO
  has_one :in, :Sensor3, type: :BELONGS_TO
  has_one :in, :Sensor4, type: :BELONGS_TO
  has_one :in, :TimeUplink, type: :BELONGS_TO
  has_one :in, :UplinkBDownlink, type: :BELONGS_TO
  has_one :in, :ValvePosition, type: :BELONGS_TO
end
