new_alarm = Alarm.create(value: nil, uplink: battery_level.uplink)

p new_alarm = Alarm.create(value: nil, uplink: accumulator.uplink)


require 'dry/transaction/operation'

class Alarms::GenerateAlarm
  include Dry::Transaction::Operation

  def call(input)
    uplink = input[:object].uplink

    if input[:alarm_name].present?
      alarm = Alarm.create(value: nil, uplink: accumulator.uplink)
      Success input.merge(alarm: alarm)
    else
      Success input
    end
  end
end
