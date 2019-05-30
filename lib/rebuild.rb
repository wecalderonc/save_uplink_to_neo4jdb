module Rebuild
  def self.messages_array(messages)
    accumulator_messages = messages.select { |message| message =~ /^(1|2)/ }
    if accumulator_messages.empty?
      messages
    else
      new_messages_array = (messages + accumulator_messages) - (messages & accumulator_messages)
      accumulator_messages_joined = join_accumulator_messages(accumulator_messages)
      new_messages_array.push(accumulator_messages_joined)
    end
  end

  def self.join_accumulator_messages(payload)
    new_payload = payload.sort_by { |message| message[0] }.reverse.join
    new_payload.slice!(5)
    new_payload
  end
end
