require 'dry/transaction/operation'

class Alarms::Accumulators::GetConditions
  include Dry::Transaction::Operation

  LIMIT = 0xffffffff

  def call(input)
    current_acc, last_acc, delta_time = input.values_at(:current_acc_value, :last_acc_value, :delta_time)
    condition_1 = (current_acc - last_acc) / delta_time
    condition_2 = (LIMIT - last_acc + current_acc) / delta_time
    input.merge(condition_1: condition_1, condition_2: condition_2)
  end
end
