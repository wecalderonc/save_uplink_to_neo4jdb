require 'dry/transaction/operation'

class Alarms::Create::GenerateAlarm
  include Dry::Transaction::Operation

  def call(input)
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
    p "input en generate alarm"
    uplink = input[:object].uplink

    if input[:alarm_name].present?
      alarm = Alarm.create(value: "0000", uplink: uplink)
      input.merge(alarm: alarm)
    else
      input
    end

  end

  def generate_accumulator_alarm(input)
    uplink = input[:object].uplink
    accumulator_alarm_name = input[:accumulator_alarm_name]

    if accumulator_alarm_name[:unexpected_dump]
      alarm = Alarm.create(value: "0000", uplink: uplink)
      alarm2 = Alarm.create(value: "0000", uplink: uplink)

      input.merge(alarm: alarm, alarm2: alarm2)
    elsif accumulator_alarm_name[:imposible_consumption]
      alarm = Alarm.create(value: "0000", uplink: uplink)

      input.merge(alarm: alarm)
    else
      input
    end
  end
end
