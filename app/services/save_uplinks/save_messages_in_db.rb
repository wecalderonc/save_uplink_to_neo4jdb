require 'dry/transaction/operation'
require './lib/errors.rb'

class SaveUplinks::SaveMessagesInDb
  include Dry::Transaction::Operation

  def call(input)
    possible_errors = input[:new_messages].map do |message|
      bit_descriptor = message[0]

      result = uplink_attributes[bit_descriptor].(message[1..10], input[:uplink]).success

      if not result.save
        Errors.general_error(result.errors.messages, self.class)
      else
        { message: "Messages Saved Successfully", bit_descriptor: bit_descriptor }
      end
    end

    Success(results: possible_errors.compact)
  end

  private

  #TODO CHANGE CODE FLOW
  def uplink_attributes
    sensors = {
      "2"=> lambda { |value, uplink| Alarms::Create::Execute.(object: Accumulator.new(value: value, uplink: uplink), model: :accumulator, type: "software") },
      "3"=> lambda { |value, uplink| Alarms::Create::Execute.(object: BatteryLevel.new(value: value, uplink: uplink), model: :battery_level, type: "hardware") },
      "4"=> lambda { |value, uplink| success_monad(ValvePosition.new(value: value, uplink: uplink)) },
      "5"=> lambda { |value, uplink| success_monad(TimeUplink.new(value: value, uplink: uplink)) },
      "6"=> lambda { |value, uplink| success_monad(UplinkBDownlink.new(value: value, uplink: uplink)) },
      "7"=> lambda { |value, uplink| success_monad(Sensor1.new(value: value, uplink: uplink)) },
      "8"=> lambda { |value, uplink| success_monad(Sensor2.new(value: value, uplink: uplink)) },
      "9"=> lambda { |value, uplink| success_monad(Sensor3.new(value: value, uplink: uplink)) },
      "a"=> lambda { |value, uplink| success_monad(Sensor4.new(value: value, uplink: uplink)) },
      "b"=> lambda { |value, uplink| Alarms::Create::Execute.(object: Alarm.new(value: value, uplink: uplink), model: :alarm, type: "hardware") }
    }

    sensors.default = lambda { |_, _| success_monad(Struct.new(:save).new(true)) }
    sensors
  end

  def success_monad(object)
    Dry::Monads::Result::Success.new(object)
  end
end
