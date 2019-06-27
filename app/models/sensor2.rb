require_relative 'base_model.rb'

class Sensor2 < BaseModel

  property :value, type: String

  validates :value, presence: true

  has_one :out, :uplink, type: :BELONGS_TO
end
