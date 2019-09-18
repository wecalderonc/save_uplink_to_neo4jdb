require 'dry/transaction/operation'

class Alarms::Save
  include Dry::Transaction::Operation

  def call(input)
    p "input en save"
    p input

    options = {
      accumulator: -> input { save_accumulator_alarm_type(input) },
      alarm: -> input { save_alarm_type_for_alarm(input) },
      battery_level: -> input { save_battery_level_alarm_type(input) }
    }

    options.default = lambda { Success input }

    Success options[input[:model]].(input)
  end

  private

  def save_alarm_type_for_alarm(input)
    p "inside save alarm type for alamr"
    input[:object]
    # name = input[:name]
    # alarm = input[:alarm]

    # alarm_type = AlarmType.new(name: name, value: input[:last_digit], type: input[:type], alarm: alarm)

    # if alarm_type.save
    #   alarm.alarm_type = alarm_type
    #   Success alarm
    # else
    #   Failure Errors.general_error(alarm_type.errors.messages, self.class)
    # end
  end

  def save_accumulator_alarm_type(input)
    p "inside save alarm type for accumulator"
    input[:object]
  end

  def save_battery_level_alarm_type(input)
    p "inside save alarm type for battery_level"
    input[:object]
  end
end
