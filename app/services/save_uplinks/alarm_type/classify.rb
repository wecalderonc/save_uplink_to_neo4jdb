require 'dry/transaction/operation'

class Alarms::Classify
  include Dry::Transaction::Operation

  def call(input)
    alarm = input[:alarm]

    if HARDWARE_ALARMS.include?(last_digit)
      input.merge(hardware_type: HARDWARE_ALARMS[last_digit], last_digit: last_digit)
    else
      input.merge(hardware_type: :does_not_apply, last_digit: last_digit)
    end
  end

  private

  def last_digit
    alarm.value[-1].to_i
  end
end
