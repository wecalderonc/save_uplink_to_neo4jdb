require_relative 'container.rb'

#Transaction for save uplinks in neo4jdb
class SaveUplinks
  include Dry::Transaction(container: Container)

  step :validate_input,                 with: "save_uplinks.validate_input"
  step :validate_thing_existence,       with: "save_uplinks.validate_thing_existence"
  map  :parse_data,                     with: "parse_data"
  step :build_uplink,                   with: "save_uplinks.build_uplink"
  step :create_uplink,                  with: "save_uplinks.create_uplink"

  def execute(input)
    self.call(input)
  end

  private

  def parse_data(input)
    data = input[:params][:state][:reported][:data]
    messages = split_message(data)
    input.merge(messages: messages)
  end

  def split_message(payload)
    payload.reverse.split('').each_slice(5).map {|message| message.reverse.join}
  end
end


