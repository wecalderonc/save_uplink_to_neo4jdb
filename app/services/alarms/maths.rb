require './app/services/alarms/maths.rb'

module Alarms::Maths
  def self.aja(last_accumulator, current_accumulator, flow_per_minute)
    last_acc = last_accumulator.value.to_i(16)
    current_acc = current_accumulator.value.to_i(16)
    time_1 = current_accumulator.uplink.time.to_date
    time_2 = last_accumulator.uplink.time.to_date
    delta_time = time_1 - time_2

    if curr_acc < last_acc
      unexpected = (current_acc - last_acc)/delta_time
      if unexpected > flow_per_minute
        base_alarms[:unexpected_dump] = true
      end
    end

    if current_acc > last_acc
      imposible = (current_acc - last_acc)/delta_time
      if imposible > flow_per_minute
        base_alarms[:imposible_consumption] = true
      end
    end

    base_alarms
  end

  def base_alarms
    {
      unexpected_dump: false,
      imposible_consumption: false
    }
  end
end
