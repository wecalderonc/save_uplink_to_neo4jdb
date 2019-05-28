require 'dry/transaction/operation'
require './lib/errors.rb'
require './app/models/accumulator.rb'
require './app/models/sensor1.rb'
require './app/models/sensor2.rb'
require './app/models/sensor3.rb'
require './app/models/sensor4.rb'
require './app/models/valve_position.rb'
require './app/models/battery_level.rb'
require './app/models/time_uplink.rb'
require './app/models/uplink_b_downlink.rb'
require './app/models/alarm.rb'


class SaveUplinks::SaveMessagesInDB
  include Dry::Transaction::Operation

  def call(input)
    @first_bits, @second_bits = "0", "0"
    p "aquí"
    messages = input[:messages][0..3]
    messages.each do |message|
      bit_descriptor = message[0]
        if uplink_attributes.keys.include? (bit_descriptor)
          result = uplink_attributes[bit_descriptor].(message[1..4], input[:uplink])
          result.save if result.class != String && result.valid?
        end
    end
    Success input
  end

  private

  def uplink_attributes
    {
      "1"=> lambda { |value, uplink| @second_bits == "0" ? @first_bits = value : Accumulator.new(value: @second_bits + value, uplink: uplink)},
      "2"=> lambda { |value, uplink| @first_bits == "0" ? @second_bits = value : Accumulator.new(value: value + @first_bits, uplink: uplink) },
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
  end
end
