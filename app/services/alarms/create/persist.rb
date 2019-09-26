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

    if alarm_name.present?
      AlarmType.create(name: alarm_name, value: input[:last_digit], type: input[:type], alarm: alarm)
    end

    input[:object]
  end

  def save_accumulator_alarm_type(input)
    options = {
      true =>  -> input { unexpected_dump(input) },
      false => -> input { imposible_consumption_or_no_alarm(input) }
    }

    options.default = input

    check = input[:accumulator_alarm_name].values.all?
    options[check].(input)
  end

  def unexpected_dump(input)
    AlarmType.create(create_attrs(input[:type], :unexpected_dump, input[:unexpected_dump_alarm]))
    AlarmType.create(create_attrs(input[:type], :imposible_consumption, input[:impossible_consumption_alarm]))
    input[:object]
  end

  def imposible_consumption_or_no_alarm(input)
    alarm = input[:impossible_consumption_alarm]

    if input[:accumulator_alarm_name][:imposible_consumption]
      alarm_type_attrs = {
        name: :imposible_consumption,
        value: "0",
        type: input[:type],
        alarm: alarm
      }
      AlarmType.create(alarm_type_attrs)
    end

    input[:object]
  end

  def create_attrs(type, alarm_name, alarm)
   { name: alarm_name, value: "0", type: type, alarm: alarm }
  end
end
