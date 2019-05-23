require 'dry/transaction/operation'

#Separa el mensaje enviado como UPLINK desde el dispositivo vía Sigfox y guarda la info en cada modelo
class SaveUplinks::SaveMessagesSeparatedInDB
  include Dry::Transaction::Operation

  def call(input)
    @first_bits, @second_bits = "0", "0"
    messages = input[:messages][0..3]
    messages.each do |message|
      bit_descriptor = message[0]
        if uplink_attributes.keys.include? (bit_descriptor)
          #result = uplink_attributes[bit_descriptor].(message[1..4], input[:uplink].id)
          #result.save if result.class != String && result.valid?
          #p result = "result in save_messages_separated_in_db"
        end
    end

    if true
      Success input
    else
      Failure "fallo al final"
    end
  end

  private

  def uplink_attributes
    {
      "1"=> lambda { |value, uplink_id| @second_bits == "0" ? @first_bits = value : Acumulator.new(value: @second_bits + value, uplink_id: uplink_id)},
      "2"=> lambda { |value, uplink_id| @first_bits == "0" ? @second_bits = value : Acumulator.new(value: value + @first_bits, uplink_id: uplink_id) },
      "3"=> lambda { |value, uplink_id| BatteryLevel.new(value: value, uplink_id: uplink_id) },
      "4"=> lambda { |value, uplink_id| ValvePosition.new(value: value, uplink_id: uplink_id) },
      "5"=> lambda { |value, uplink_id| TimeUplink.new(value: value, uplink_id: uplink_id) },
      "6"=> lambda { |value, uplink_id| UplinkBDownlink.new(value: value, uplink_id: uplink_id) },
      "7"=> lambda { |value, uplink_id| Sensor1.new(value: value, uplink_id: uplink_id) },
      "8"=> lambda { |value, uplink_id| Sensor2.new(value: value, uplink_id: uplink_id) },
      "9"=> lambda { |value, uplink_id| Sensor3.new(value: value, uplink_id: uplink_id) },
      "a"=> lambda { |value, uplink_id| Sensor4.new(value: value, uplink_id: uplink_id) },
      "b"=> lambda { |value, uplink_id| Alarm.new(value: value, uplink_id: uplink_id) }
    }
  end
end
