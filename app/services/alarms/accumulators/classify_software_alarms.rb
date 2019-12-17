require 'dry/transaction/operation'

class Alarms::Accumulators::ClassifySoftwareAlarms
  include Dry::Transaction::Operation

  def call(input)
    current_accumulator = input[:current_accumulator]
    base_alarms = { unexpected_dump: false, impossible_consumption: false }
    current_acc, last_acc, impossible_consumption, unexpected_dump, flow_per_minute = input
      .values_at(:current_acc_value, :last_acc_value, :impossible_consumption, :unexpected_dump, :flow_per_minute)

    if (current_acc < last_acc) && (unexpected_dump > flow_per_minute)
      base_alarms[:unexpected_dump] = true
      base_alarms[:impossible_consumption] = true
      current_accumulator.update(is_an_overturning: true)
    end

    if (current_acc > last_acc) && (impossible_consumption > flow_per_minute)
      base_alarms[:impossible_consumption] = true
      current_accumulator.update(is_an_overturning: true)
    end

    base_alarms
  end
end
