require 'dry/transaction/operation'

class Alarms::Accumulators::ClassifySoftwareAlarms
  include Dry::Transaction::Operation

  def call(input)
    base_alarms = { unexpected_dump: false, imposible_consumption: false }
    current_acc, last_acc, condition_1, condition_2, flow_per_minute = input
      .values_at(:current_acc_value, :last_acc_value, :condition_1, :condition_2, :flow_per_minute)

    if (current_acc < last_acc) && (condition_2 > flow_per_minute)
      base_alarms[:unexpected_dump] = true
      base_alarms[:imposible_consumption] = true
    end

    if (current_acc > last_acc) && (condition_1 > flow_per_minute)
      base_alarms[:imposible_consumption] = true
    end

    base_alarms
  end
end
