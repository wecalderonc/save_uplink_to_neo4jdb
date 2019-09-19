require 'dry/transaction/operation'

class Alarms::Classify
  include Dry::Transaction::Operation

  def call(input)
    uplink = input[:object].uplink

    options = {
      accumulator:      -> input { accumulator_alarm_classify(input) },
      alarm:            -> input { classify_alarm(input) },
      battery_level:    -> input { battery_level_alarm_classify(input)}
    }

    options.default = lambda { Success input }

    options[input[:model]].(input)
  end

  private

  def last_digit(object)
    object.value[-1].to_i
  end

  def classify_alarm(input)
    alarm = input[:object]
    last_digit = last_digit(alarm)
    alarm_name = AlarmType::HARDWARE_ALARMS[last_digit] || :does_not_apply
    Success input.merge(alarm_name: alarm_name)
  end

  def battery_level_alarm_classify(input)
    battery_level = input[:object]
    last_digit = last_digit(battery_level)

    if last_digit.eql?(1)
      alarm_name = AlarmType::SOFTWARE_ALARMS[3]

      Success input.merge(alarm_name: alarm_name)
    else
      Success input
    end
  end


  def accumulator_alarm_classify(input)
    accumulator = input[:object]

    if "calculos y metodos de jeisson"
      alarm_name = "lo que diga jei jei"

      Success input.merge(alarm_name: alarm_name)
    else
      Success input
    end
  end
end
