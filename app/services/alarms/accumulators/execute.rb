module Alarms::Accumulators
  _, Execute = Common::TxMasterBuilder.new do
    map :get_accumulators_value, with: Alarms::Accumulators::GetAccumulatorsValue.new
    map :get_delta_time,         with: Alarms::Accumulators::GetDeltaTime.new
    map :get_conditions,         with: Alarms::Accumulators::Calculate.new
    map :classify_alarms,        with: Alarms::Accumulators::ClassifySoftwareAlarms.new
  end.Do
end
