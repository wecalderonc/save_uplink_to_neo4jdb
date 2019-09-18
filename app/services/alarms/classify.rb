require 'dry/transaction/operation'

class Alarms::Classify
  include Dry::Transaction::Operation

  def call(input)
    p "uplink"
    p uplink = input[:object].uplink

    options = {
      accumulator:      -> input { accumulator_alarm_classify(input) },
      alarm:            -> input { classify_alarm(input) },
      battery_level:    -> input { battery_level_alarm_classify(input)}
    }

    options.default = lambda { Success input }

    options[input[:model]].(input)
  end

  private

  def last_digit(alarm)
    alarm.value[-1].to_i
  end

  def classify_alarm(input)
    p "inside alarm classify"
    alarm = input[:object]
    last_digit = last_digit(alarm)

    if AlarmType::HARDWARE_ALARMS.include?(last_digit)
      name = AlarmType::HARDWARE_ALARMS[last_digit]
      Success input.merge(alarm_type: AlarmType.new(name: name, value: last_digit, type: input[:type], alarm: alarm))
    else
      name = :does_not_apply
      Success input.merge(alarm_type: AlarmType.new(name: name, value: last_digit, type: input[:type], alarm: alarm))
    end
  end

  def battery_level_alarm_classify(input)
    p "inside battery_level_alarm_classify"
    battery_level = input[:object]
    last_digit = battery_level.value[-1].to_i

    if last_digit.eql?(1)
      alarm_name = AlarmType::SOFTWARE_ALARMS[3]
      p new_alarm = Alarm.create(value: nil, uplink: battery_level.uplink)
      Success input.merge(alarm_type: AlarmType.new(name: alarm_name, value: last_digit, type: input[:type], alarm: new_alarm))
    else
      Success input
    end
  end


  def accumulator_alarm_classify(input)
    p "inside accumulator_level_alarm_classify"
    accumulator = input[:object]

    if "calculos y metodos de jeisson"
      p new_alarm = Alarm.create(value: nil, uplink: accumulator.uplink)
      Success input
    else
      Success input
    end
  end
end
