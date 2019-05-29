require_relative 'container.rb'
require './lib/rebuild.rb'

class SaveUplinks
  include Dry::Transaction(container: Container)

  step :validate_input,                 with: "save_uplinks.validate_input"
  step :validate_thing_existence,       with: "save_uplinks.validate_thing_existence"
  map  :parse_data,                     with: "parse_data"
  step :build_uplink,                   with: "save_uplinks.build_uplink"
  step :create_uplink,                  with: "save_uplinks.create_uplink"
  map :reconstruct_messages_in_uplink, with: "save_uplinks.reconstruct_messages_in_uplink"
  step :save_messages_in_db,            with: "save_uplinks.save_messages_in_db"

  def execute(input)
    self.call(input)
  end

  private

  def parse_data(input)
    data = input[:params][:state][:reported][:data]
    messages = split_message(data)
    input.merge(messages: messages)
  end

  def reconstruct_messages_in_uplink(input)
    messages = input[:messages][0..3]
    new_messages = Rebuild.messages_array(messages)
    input.merge(new_messages: new_messages)
  end

  def split_message(payload)
    payload.reverse.split('').each_slice(5).map {|message| message.reverse.join}
  end
end


