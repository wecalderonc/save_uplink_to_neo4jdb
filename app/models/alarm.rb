require './app/models/alarm_type.rb'

class Alarm < BaseModel

  property :viewed_date, type: Date
  property :viewed,      type: Boolean, default: false

  has_one :out, :alarm_type, type: :TYPE

  after_save :create_alarm_type

  def classify(last_digit)
    if AlarmType::HARDWARE_ALARMS.include?(last_digit)
      AlarmType::HARDWARE_ALARMS[last_digit]
    else
      :does_not_apply
    end
  end

  def last_digit
    self.value[-1].to_i
  end

  private

  def create_alarm_type
    name = classify(self.last_digit)
    AlarmType.create(name: name, value: last_digit, type: "hardware", alarm: self)
  end
end
