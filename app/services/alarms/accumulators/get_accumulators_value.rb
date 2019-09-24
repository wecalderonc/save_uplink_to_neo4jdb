require 'dry/transaction/operation'

class Alarms::Accumulators::GetAccumulatorsValue
  include Dry::Transaction::Operation

  def call(input)
    last_acc = get_accumulator_value(input[:last_accumulator])
    current_acc = get_accumulator_value(input[:current_accumulator])
    input.merge(last_acc_value: last_acc, current_acc_value: current_acc)
  end

  def get_accumulator_value(accumulator)
    accumulator.value.to_i(16)
  end
end
