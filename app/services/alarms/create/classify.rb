require 'dry/transaction/operation'

class Alarms::Create::Classify
  include Dry::Transaction::Operation

  def call(input)
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

    Success input.merge(alarm_name: alarm_name, last_digit: last_digit)
  end

  def battery_level_alarm_classify(input)
    battery_level = input[:object]
    last_digit = last_digit(battery_level)

    if last_digit.eql?(1)
      alarm_name = AlarmType::SOFTWARE_ALARMS[3]

      Success input.merge(alarm_name: alarm_name, last_digit: last_digit)
    else
      Success input
    end
  end

  def accumulator_alarm_classify(input)
    flow_per_minute = input[:object].uplink.thing.flow_per_minute
    current_accumulator = input[:object]
    last_accumulator = input[:object].uplink.thing.last_accumulators(2).compact[0]

    accumulator_alarm_name = Alarms::Accumulators::Execute.new.(current_accumulator: current_accumulator, last_accumulator: last_accumulator, flow_per_minute: flow_per_minute)

    Success input.merge(accumulator_alarm_name: accumulator_alarm_name.success)
  end
end
