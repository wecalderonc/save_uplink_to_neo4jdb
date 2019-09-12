class AlarmType < BaseModel

  property :name,   type: String
  property :value,  type: Integer
  property :type,   type: String

  validates :name,  presence: true
  validates :type,  presence: true

  has_one :in, :alarm, type: :TYPE

  HARDWARE_ALARMS = {
    1 => :power_connection,
    2 => :induced_site_alarm,
    3 => :sos
  }
end
