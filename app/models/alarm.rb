require './app/models/alarm_type.rb'

class Alarm < BaseModel

  property :viewed_date, type: Date
  property :viewed,      type: Boolean, default: false

  has_one :out, :alarm_type, type: :TYPE

end
