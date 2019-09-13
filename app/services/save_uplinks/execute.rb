module SaveUplinks
  _, Execute = Common::TxMasterBuilder.new do
    step :validate_input,                 with: Common::Operations::Validator.(:get_state, :uplink)
    step :validate_thing_existence,       with: SaveUplinks::ValidateThingExistence.new
    map  :parse_data,                     with: SaveUplinks::ParseData.new
    step :build_uplink,                   with: SaveUplinks::BuildUplink.new
    step :create_uplink,                  with: SaveUplinks::CreateUplink.new
    map  :reconstruct_messages_in_uplink, with: SaveUplinks::ReconstructMessagesInUplink.new
    step :save_messages_in_db,            with: SaveUplinks::SaveMessagesInDb.new
  end.Do
end
