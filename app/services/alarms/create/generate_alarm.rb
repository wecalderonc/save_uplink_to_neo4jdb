require 'dry/transaction/operation'

class Alarms::GenerateAlarm
  include Dry::Transaction::Operation

  def call(input)
    p "generate_alarm"
    p input
    p "generate_alarm"

    options = {
      accumulator: -> input { generate_accumulator_alarm(input) },
      alarm: -> input { generate_alarm(input) },
      battery_level: -> input { generate_alarm(input) }
    }

    options.default = lambda { Success input }

    Success options[input[:model]].(input)
  end

  private

  def generate_alarm(input)
    uplink = input[:object].uplink

    if input[:alarm_name].present?
      p alarm = Alarm.create(value: nil, uplink: uplink)
      input.merge(alarm: alarm)
    else
      input
    end

  end

  def generate_accumulator_alarm(input)
    p uplink = input[:object].uplink
    accumulator_alarm_name = input[:accumulator_alarm_name]

    if accumulator_alarm_name[:unexpected_dump]
      p alarm = Alarm.create(value: "0000", uplink: uplink)
      p alarm2 = Alarm.create(value: "0000", uplink: uplink)

      input.merge(alarm: alarm, alarm2: alarm2)
    elsif accumulator_alarm_name[:imposible_consumption]
      p alarm = Alarm.create(value: nil, uplink: uplink)

      input.merge(alarm: alarm)
    else
      input
    end
  end
end
