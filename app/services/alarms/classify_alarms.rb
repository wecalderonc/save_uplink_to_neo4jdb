require 'dry/transaction/operation'

class Alarms::ClassifyAlarms
  include Dry::Transaction::Operation

  BASE_ALARMS =  {
    unexpected_dump: false,
    imposible_consumption: false
  }

  def call(input)
    current_acc, last_acc, condition_1, condition_2, flow_per_minute = input
      .values_at(:current_acc_value, :last_acc_value, :condition_1, :condition_2, :flow_per_minute)

    if (current_acc < last_acc) && (condition_2 > flow_per_minute)
      BASE_ALARMS[:unexpected_dump] = true
      BASE_ALARMS[:imposible_consumption] = true
    end

    if (current_acc > last_acc) && (condition_1 > flow_per_minute)
      BASE_ALARMS[:imposible_consumption] = true
    end

    BASE_ALARMS
  end
end
