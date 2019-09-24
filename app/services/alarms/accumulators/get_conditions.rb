require 'dry/transaction/operation'

class Alarms::Accumulators::GetConditions
  include Dry::Transaction::Operation

  LIMIT = 0xffffffff

  def call(input)
    current_acc, last_acc, delta_time = input.values_at(:current_acc_value, :last_acc_value, :delta_time)

    input.merge!(condition_1: (current_acc - last_acc) / delta_time)
    input.merge!(condition_2: (LIMIT - last_acc + current_acc) / delta_time)
  end
end
