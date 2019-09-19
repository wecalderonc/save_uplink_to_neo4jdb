require 'dry/transaction/operation'

class Alarms::Persist
  include Dry::Transaction::Operation

  def call(input)

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
    p "inside save alarm type"
    alarm_type = input[:alarm_type]

    if alarm_type.save
      Success input[:object]
    else
      Failure Errors.general_error(alarm_type.errors.messages, self.class)
      Success input[:object]
    end
  end

  def save_accumulator_alarm_type(input)
    p "inside save alarm type for accumulator"
    input[:object]
  end
end





AlarmType.new(name: name, value: last_digit, type: input[:type], alarm: alarm)
AlarmType.new(name: alarm_name, value: last_digit, type: input[:type], alarm: new_alarm)
AlarmType.new(name: alarm_name, value: nil, type: input[:type], alarm: new_alarm)
