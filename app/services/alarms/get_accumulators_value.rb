require 'dry/transaction/operation'

class Alarms::GetAccumulatorsValue
  include Dry::Transaction::Operation

  def call(input)
    input.merge!(last_acc_value: get_accumulator_value(input[:last_accumulator]))
    input.merge!(current_acc_value: get_accumulator_value(input[:current_accumulator]))
  end

  private

  def get_accumulator_value(accumulator)
    accumulator.value.to_i(16)
  end
end
