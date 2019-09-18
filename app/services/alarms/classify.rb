require 'dry/transaction/operation'

class Alarms::Classify
  include Dry::Transaction::Operation

  def call(input)

    options = {
      accumulator: -> input { accumulator_alarm_classify(input) },
      alarm: -> input { alarm_classify(input) },
      battery_level: -> input { battery_level_alarm_classify(input)}
    }

    options.default = lambda { Success input }

    options[input[:model]].(input)
  end

  private

  def last_digit(alarm)
    alarm.value[-1].to_i
  end

  def alarm_classify(input)
    p "inside alarm classify"
    alarm = input[:object]
    last_digit = last_digit(alarm)
    if AlarmType::HARDWARE_ALARMS.include?(last_digit)
      Success input.merge(name: AlarmType::HARDWARE_ALARMS[last_digit], last_digit: last_digit)
    else
      Success input.merge(name: :does_not_apply, last_digit: last_digit)
    end
  end

  def battery_level_alarm_classify(input)
    p "inside battery_level_alarm_classify"
    p input
    Success input
  end


  def accumulator_alarm_classify(input)
    p "inside accumulator_level_alarm_classify"
    p input
    Success input
  end
end
