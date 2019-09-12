require './app/services/common/tx_master_builder.rb'
require './app/services/common/operations.rb'
require './app/services/common/container.rb'

module SaveUplinks
  _, Execute = Common::TxMasterBuilder.new do
    step :validate_input,                 with: Common::Operations::Validator.(:get_state, :uplink)
    step :validate_thing_existence,       with: SaveUplinks::ValidateThingExistence.new
    map  :parse_data,                     with: ParseData.new
    step :build_uplink,                   with: SaveUplinks::BuildUplink.new
    step :create_uplink,                  with: SaveUplinks::CreateUplink.new
    map  :reconstruct_messages_in_uplink, with: ReconstructMessagesInUplink.new
    step :save_messages_in_db,            with: SaveUplinks::SaveMessagesInDb.new
  end.Do

  private

  def parse_data(input)
    data = input[:state][:reported][:data]
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
