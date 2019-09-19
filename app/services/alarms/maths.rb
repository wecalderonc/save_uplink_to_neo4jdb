require './app/services/alarms/maths.rb'

module Alarms::Maths
  LIMIT = 10000

  def self.equations(last_accumulator, current_accumulator, flow_per_minute)
    base_alarms = {
      unexpected_dump: false,
      imposible_consumption: false
    }

    last_acc = last_accumulator.value.to_i(16)
    current_acc = current_accumulator.value.to_i(16)
    time_1 = Time.at current_accumulator.uplink.time.to_i
    time_2 = Time.at last_accumulator.uplink.time.to_i
    delta_time = (time_1 - time_2) / 60

    main_condition = (current_acc - last_acc) / delta_time
    main_condition_2 = (LIMIT - last_acc + current_acc) / delta_time

    if (current_acc < last_acc) && (main_condition_2 > flow_per_minute)
      base_alarms[:unexpected_dump] = true
      base_alarms[:imposible_consumption] = true
    end

    if (current_acc > last_acc) && (main_condition > flow_per_minute)
      base_alarms[:imposible_consumption] = true
    end

    base_alarms
  end
end
