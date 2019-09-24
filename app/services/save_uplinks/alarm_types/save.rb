require 'dry/transaction/operation'

class SaveUplinks::AlarmTypes::Classify::Save
  include Dry::Transaction::Operation

  def call(input)
    alarm = input[:alarm]

    alarm_type = AlarmType.new(name: input[:hardware_type], value: input[:last_digit], type: :hardware, alarm: alarm)

    if alarm_type.save
      alarm.update(alarm_type: alarm_type)
      Success alarm
    else
      Failure Errors.general_error(alarm_type.errors.messages, self.class)
    end
  end
end
