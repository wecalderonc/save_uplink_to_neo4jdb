require './app/services/alarm_types.rb'
require './app/services/save_uplinks/alarm_types/classify.rb'
require './app/services/save_uplinks/alarm_types/save.rb'
module SaveUplinks::AlarmTypes
  _, Execute = Common::TxMasterBuilder.new do
    step :validate_input,        with: Common::Operations::Validator.(:create, :alarm_type)
    step :classify,              with: SaveUplinks::AlarmTypes::Classify.new
    step :save,                  with: SaveUplinks::AlarmTypes::Classify::Save.new
  end.Do
end
