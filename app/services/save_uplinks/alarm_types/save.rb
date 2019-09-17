require 'dry/transaction/operation'

class SaveUplinks::AlarmTypes::Classify::Save
  include Dry::Transaction::Operation

  def call(input)
    name = input[:hardware_type]
    last_digit = input[:last_digit]
    alarm = input[:alarm]

    alarm_type = AlarmType.new(name: name, value: last_digit, type: :hardware, alarm: alarm)

    if alarm_type.save
      alarm.alarm_type = alarm_type
      Success alarm
    else
      Failure Errors.general_error(alarm_type.errors.messages, self.class)
    end
  end
end
