require 'dry/transaction/operation'

class SaveUplinks::ReconstructMessagesInUplink
  include Dry::Transaction::Operation

  def call(input)
    messages = input[:messages][0..3]
    new_messages = Rebuild.messages_array(messages)
    input.merge(new_messages: new_messages)
  end
end
