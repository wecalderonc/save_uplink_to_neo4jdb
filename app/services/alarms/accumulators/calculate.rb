require 'dry/transaction/operation'

class Alarms::Accumulators::Calculate
  include Dry::Transaction::Operation

  LIMIT = 0xffffffff

  def call(input)
    attributes = input.values_at(:current_acc_value, :last_acc_value, :delta_time)
    options = {
      imposible_consumption: imposible_consumption?(*attributes),
      unexpected_dump: unexpected_dump?(*attributes)
    }

    input.merge(options)
  end

  private

  def imposible_consumption?(current_acc, last_acc, delta_time)
    (current_acc - last_acc) / delta_time
  end

  def unexpected_dump?(current_acc, last_acc, delta_time)
    (LIMIT - last_acc + current_acc) / delta_time
  end
end
