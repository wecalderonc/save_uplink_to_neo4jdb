require 'dry/transaction/operation'
require './lib/errors.rb'

class SaveUplinks::SaveMessagesInDB
  include Dry::Transaction::Operation

  def call(input)
    possible_errors = input[:new_messages].map do |message|
      bit_descriptor = message[0]
      result = uplink_attributes[bit_descriptor].(message[1..10], input[:uplink])
      if not result.save
        Errors.general_error(result.errors.messages, self.class)
      end
    end
    Success(results: possible_errors.compact)
  end

  private

  def uplink_attributes
    sensors = {
      "2"=> lambda { |value, uplink| Accumulator.new(value: value, uplink: uplink) },
      "3"=> lambda { |value, uplink| BatteryLevel.new(value: value, uplink: uplink) },
      "4"=> lambda { |value, uplink| ValvePosition.new(value: value, uplink: uplink) },
      "5"=> lambda { |value, uplink| TimeUplink.new(value: value, uplink: uplink) },
      "6"=> lambda { |value, uplink| UplinkBDownlink.new(value: value, uplink: uplink) },
      "7"=> lambda { |value, uplink| Sensor1.new(value: value, uplink: uplink) },
      "8"=> lambda { |value, uplink| Sensor2.new(value: value, uplink: uplink) },
      "9"=> lambda { |value, uplink| Sensor3.new(value: value, uplink: uplink) },
      "a"=> lambda { |value, uplink| Sensor4.new(value: value, uplink: uplink) },
      "b"=> lambda { |value, uplink| Alarm.new(value: value, uplink: uplink) }
    }

    sensors.default = lambda { |_, _| Struct.new(:save).new(true) }
    sensors
  end
end
