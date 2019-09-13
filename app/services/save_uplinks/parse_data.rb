require 'dry/transaction/operation'

class SaveUplinks::ParseData
  include Dry::Transaction::Operation

  def call(input)
    data = input[:state][:reported][:data]
    messages = split_message(data)
    input.merge(messages: messages)
  end

  private

  def split_message(payload)
    payload.reverse.split('').each_slice(5).map {|message| message.reverse.join}
  end
end
