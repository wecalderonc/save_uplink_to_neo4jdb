require 'dry/transaction/operation'

class Alarms::GetDeltaTime
  include Dry::Transaction::Operation

  def call(input)
    time_1 = accumulator_time(input[:current_accumulator])
    time_2 = accumulator_time(input[:last_accumulator])

    input.merge!(delta_time: (time_1 - time_2) / 60)
  end

  private

  def accumulator_time(accumulator)
    Time.at accumulator.uplink.time.to_i
  end
end
