require './app/services/alarm_types.rb'
require './app/services/save_uplinks/alarm_types/validate.rb'
require './app/services/save_uplinks/alarm_types/classify.rb'
require './app/services/save_uplinks/alarm_types/save.rb'
module AlarmTypes
  _, Execute = Common::TxMasterBuilder.new do
#    step :validation,            with: Common::Operations::Validator.(:create, :alarm_type)
    step :validate_alarm,        with: SaveUplinks::AlarmTypes::Validate.new
   # step :get_alarm,             with: Alarms::Get.new
    step :classify,              with: SaveUplinks::AlarmTypes::Classify.new
    step :save,                  with: SaveUplinks::AlarmTypes::Classify::Save.new
  end.Do
end
