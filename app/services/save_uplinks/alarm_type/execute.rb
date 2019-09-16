module AlarmType::Index
  _, Execute = Common::TxMasterBuilder.new do
    step :validation,            with: Common::Operations::Validator.(:type, :alarm)
    step :get_alarm,             with: Alarms::Get.new
    step :classify,              with: Alarms::Classify.new
    step :save,                  with: Alarms::Classify::Save.new
  end.Do
end
