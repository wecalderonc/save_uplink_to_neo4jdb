require 'dry/transaction/operation'

class Alarms::Persist
  include Dry::Transaction::Operation

  def call(input)
    input
    input[:model]

    options = {
      accumulator: -> input { save_accumulator_alarm_type(input) },
      alarm: -> input { save_alarm_type(input) },
      battery_level: -> input { save_alarm_type(input) }
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
      p "por aquí con batter"
      p input[:object]
    else
      input[:object]
    end
  end

  def save_accumulator_alarm_type(input)
    accumulator_alarm_name = input[:accumulator_alarm_name]

    if accumulator_alarm_name[:unexpected_dump]
      alarm = input[:alarm]
      alarm2 = input[:alarm2]

      AlarmType.create(name: :unexpected_dump, value: "0", type: input[:type], alarm: alarm)
      AlarmType.create(name: :imposible_consumption, value: "0", type: input[:type], alarm: alarm2)

      input[:object]
    elsif accumulator_alarm_name[:imposible_consumption]
      alarm = input[:alarm]
      AlarmType.create(name: :imposible_consumption, value: "0", type: input[:type], alarm: alarm)

      input[:object]
    else
      input[:object]
    end
  end
end
