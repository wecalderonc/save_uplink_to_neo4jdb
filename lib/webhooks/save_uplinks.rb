#Transacción para guardar en DB los mensajes enviados desde el dispositivo.
require_relative 'webhook_container.rb'

class Webhooks::SaveUplinks
  include Dry::Transaction(container: Webhooks::WebhookContainer)

  step :validate_input,                 with: "save_uplinks.validate_input"
  step :validate_thing_existence,       with: "save_uplinks.validate_thing_existence"
  map  :parse_data,                     with: "parse_data"
  step :build_uplink,                   with: "save_uplinks.build_uplink"
  step :create_uplink,                  with: "save_uplinks.create_uplink"
  step :save_messages_separated_in_db,  with: "save_uplinks.save_messages_separated_in_db"


  def execute(input)
    self.call(input)
  end

  private

  def parse_data(input)
    data = input[:params][:state][:reported][:data]
    messages = MessagesParser.split_message(data)
    input.merge(messages: messages)
  end
end


