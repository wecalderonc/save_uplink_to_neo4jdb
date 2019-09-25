require 'dry/transaction/operation'

class Alarms::Accumulators::ClassifySoftwareAlarms
  include Dry::Transaction::Operation

  def call(input)
    base_alarms = { unexpected_dump: false, imposible_consumption: false }
    current_acc, last_acc, imposible_consumption, unexpected_dump, flow_per_minute = input
      .values_at(:current_acc_value, :last_acc_value, :imposible_consumption, :unexpected_dump, :flow_per_minute)

    if (current_acc < last_acc) && (unexpected_dump > flow_per_minute)
      base_alarms[:unexpected_dump] = true
      base_alarms[:imposible_consumption] = true
    end

    if (current_acc > last_acc) && (imposible_consumption > flow_per_minute)
      base_alarms[:imposible_consumption] = true
    end

    base_alarms
  end
end
