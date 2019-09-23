module Alarms
  _, Maths = Common::TxMasterBuilder.new do
    map :get_accumulators_value, with: Alarms::GetAccumulatorsValue.new
    map :get_delta_time,         with: Alarms::GetDeltaTime.new
    map :get_conditions,         with: Alarms::GetConditions.new
    map :classify_alarms,        with: Alarms::ClassifyAlarms.new
  end.Do
end
