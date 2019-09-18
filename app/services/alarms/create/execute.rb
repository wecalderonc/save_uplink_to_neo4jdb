require './app/services/alarm_types.rb'
require './app/services/alarms/classify.rb'
require './app/services/alarms/save.rb'
module Alarms::Create
  _, Execute = Common::TxMasterBuilder.new do
    step :validate_input,        with: Common::Operations::Validator.(:create, :alarm)
    step :classify,              with: Alarms::Classify.new
    step :save,                  with: Alarms::Save.new
  end.Do
end
