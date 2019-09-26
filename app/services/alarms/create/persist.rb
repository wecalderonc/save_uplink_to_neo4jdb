require 'dry/transaction/operation'

class Alarms::Create::Persist
  include Dry::Transaction::Operation

  def call(input)

    options = {
      accumulator:    -> input { save_accumulator_alarm_type(input) },
      alarm:          -> input { save_alarm_type(input) },
      battery_level:  -> input { save_alarm_type(input) }
    }

    options.default = lambda { Success input }

    Success options[input[:model]].(input)
  end

  private

  def save_alarm_type(input)
    alarm_name = input[:alarm_name]
    alarm = input[:alarm]

    if alarm_name
      AlarmType.create(name: alarm_name, value: input[:last_digit], type: input[:type], alarm: alarm)
    end

    input[:object]
  end

  def save_accumulator_alarm_type(input)
    accumulator_alarm_name = input[:accumulator_alarm_name]
    alarm = input[:alarm]

    if accumulator_alarm_name[:unexpected_dump] && accumulator_alarm_name[:imposible_consumption]
      alarm2 = input[:alarm2]

      AlarmType.create(name: :unexpected_dump, value: "0", type: input[:type], alarm: alarm)
      AlarmType.create(name: :imposible_consumption, value: "0", type: input[:type], alarm: alarm2)
    end

    if accumulator_alarm_name[:imposible_consumption] && (accumulator_alarm_name[:unexpected_dump] == false)
      AlarmType.create(name: :imposible_consumption, value: "0", type: input[:type], alarm: alarm)
    end

    input[:object]
  end
end
