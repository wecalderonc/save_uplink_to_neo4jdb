module Rebuild
  def self.messages_array(messages)
    #seleccionamos los dos mensajes que inicien por 1 o 2 los cuales se relacionan con accumulator
    accumulator_messages = messages.select { |message| message =~ /^(1|2)/ }
    #limpiamos el array original para que no tenga esos mensajes de accumulator
    new_messages_array = (messages+accumulator_messages)-(messages&accumulator_messages)
    #unimos los mensajes de accumulator con el orden de bytes de mayor a menor importancia y quitamos un character
    accumulator_messages_joined = join_accumulator_messages(accumulator_messages)
    #agregamos nuevo string a array limpiado
    new_messages_array.push(accumulator_messages_joined)
  end

  def self.join_accumulator_messages(payload)
    new_payload = payload.sort_by { |t| t[0] }.reverse.join
    new_payload.slice!(5)
    new_payload
  end
end
