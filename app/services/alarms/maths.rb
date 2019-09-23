module Alarms::Maths
  LIMIT = 10000
  BASE_ALARMS =  {
    unexpected_dump: false,
    imposible_consumption: false
  }

  def self.equations(last_accumulator, current_accumulator, flow_per_minute)
    last_acc = get_accumulator_value(last_accumulator)
    current_acc = get_accumulator_value(current_accumulator)
    delta_time = get_delta_time(current_accumulator, last_accumulator)

    condition_1 = (current_acc - last_acc) / delta_time
    condition_2 = (LIMIT - last_acc + current_acc) / delta_time

    if (current_acc < last_acc) && (condition_2 > flow_per_minute)
      BASE_ALARMS[:unexpected_dump] = true
      BASE_ALARMS[:imposible_consumption] = true
    end

    if (current_acc > last_acc) && (condition_1 > flow_per_minute)
      BASE_ALARMS[:imposible_consumption] = true
    end

    BASE_ALARMS
  end

  private

  def self.get_accumulator_value(accumulator)
    accumulator.value.to_i(16)
  end

  def self.accumulator_time(accumulator)
    Time.at accumulator.uplink.time.to_i
  end

  def self.get_delta_time(current_accumulator, last_accumulator)
    time_1 = accumulator_time(current_accumulator)
    time_2 = accumulator_time(last_accumulator)
    (time_1 - time_2) / 60
  end

  def self.accumulator_time(accumulator)
    Time.at accumulator.uplink.time.to_i
  end
end
