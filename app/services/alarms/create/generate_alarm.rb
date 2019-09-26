require 'dry/transaction/operation'

class Alarms::Create::GenerateAlarm
  include Dry::Transaction::Operation

  def call(input)
    options = {
      accumulator: -> input { generate_accumulator_alarm(input) },
      battery_level: -> input { generate_alarm(input) }
    }

    options.default = lambda { Success input }

    Success options[input[:model]].(input)
  end

  private

  def generate_alarm(input)
    uplink = input[:object].uplink

    if input[:alarm_name].present?
      alarm = Alarm.create(value: "0000", uplink: uplink)
      input.merge!(alarm: alarm)
    end

    input
  end

  def generate_accumulator_alarm(input)
    uplink = input[:object].uplink
    accumulator_alarm_name = input[:accumulator_alarm_name]

    options = {
      true =>  -> input { unexpected_dump(input) },
      false => -> input { imposible_consumption_or_no_alarm(input) }
    }

    options.default = input

    options[accumulator_alarm_name.values.all?].(input)
  end

  def unexpected_dump(input)
    first_alarm = Alarm.create(value: "0000", uplink: input[:object].uplink)
    second_alarm = Alarm.create(value: "0000", uplink: input[:object].uplink)

    input.merge!(impossible_consumption_alarm: first_alarm, unexpected_dump_alarm: second_alarm)
  end

  def imposible_consumption_or_no_alarm(input)
    if input[:accumulator_alarm_name][:imposible_consumption]
      alarm = Alarm.create(value: "0000", uplink: input[:object].uplink)
      input.merge!(alarm: alarm)
    end

    input
  end
end
