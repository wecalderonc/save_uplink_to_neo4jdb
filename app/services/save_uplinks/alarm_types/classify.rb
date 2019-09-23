require 'dry/transaction/operation'

class SaveUplinks::AlarmTypes::Classify
  include Dry::Transaction::Operation

  def call(input)
    alarm = input[:alarm]
    last_digit = last_digit(alarm)
    if AlarmType::HARDWARE_ALARMS.include?(last_digit)
      Success input.merge(hardware_type: AlarmType::HARDWARE_ALARMS[last_digit], last_digit: last_digit)
    else
      Success input.merge(hardware_type: :does_not_apply, last_digit: last_digit)
    end
  end

  private

  def last_digit(alarm)
    alarm.value[-1].to_i
  end
end
