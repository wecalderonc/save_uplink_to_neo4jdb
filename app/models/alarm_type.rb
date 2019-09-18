class AlarmType < BaseModel

  property :name,   type: String
  property :value,  type: Integer
  property :type,   type: String

  validates :name,  presence: true

  TYPES = [
    :hardware,
    :software
  ]

  validates :type, presence: true, inclusion: { in: TYPES.map(&:to_s) }

  has_one :in, :alarm, type: :TYPE

  HARDWARE_ALARMS = {
    1 => :power_connection,
    2 => :induced_site_alarm,
    3 => :sos
  }

  SOFTWARE_ALARMS = {
    1 => :unexpected_dump,
    2 => :impossible_consumpsion,
    3 => :low_battery,
    4 => :stuck_valve
  }
end
