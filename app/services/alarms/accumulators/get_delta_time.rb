require 'dry/transaction/operation'

class Alarms::Accumulators::GetDeltaTime
  include Dry::Transaction::Operation

  def call(input)
    current_accumulator_time = accumulator_time(input[:current_accumulator])
    last_accumulator_time = accumulator_time(input[:last_accumulator])

    input.merge(delta_time: (current_accumulator_time - last_accumulator_time) / 60)
  end

  private

  def accumulator_time(accumulator)
    Time.at accumulator.uplink.time.to_i
  end
end
