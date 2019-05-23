#Divide los mensajes enviados en el payload (hexa) en 5 mensajes y define si se muestra el úlitmo en la bd o el que acaba de llegar
class MessagesParser
  def self.split_message(payload)
     payload.reverse.split('').each_slice(5).map {|message| message.reverse.join}
  end
  #TODO: Refactor this
  def self.get_accumulator_messages(input, thing)
    acc1data, acc2data = 0
    payload = input[:data]["state"]["reported"]["data"]
    messages = self.split_message(payload)
    messages.each do |message|
      case message[0]
      when "1"
        acc1data = message[1..4]
      when "2"
        acc2data = message[1..4]
      end
    end
    acc2data && acc1data ? acc2data + acc1data : thing.acumulators.last.value
  end
end
