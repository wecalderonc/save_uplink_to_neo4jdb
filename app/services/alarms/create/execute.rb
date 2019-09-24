require './app/services/alarms/classify.rb'
require './app/services/alarms/persist.rb'
require './app/services/alarms/create/generate_alarm.rb'

module Alarms::Create
  _, BaseTx = Common::TxMasterBuilder.new do
    step :validate_input,        with: Common::Operations::Validator.(:create, :alarm)
    step :classify,              with: Alarms::Classify.new
    step :generate_alarm,        with: Alarms::GenerateAlarm.new
    step :persist_alarm_type,    with: Alarms::Persist.new
  end.Do

  Proxy = {
    accumulator:    BaseTx.new,
    battery_level:  BaseTx.new,
    alarm:          BaseTx.new(
      generate_alarm: -> input { Dry::Monads::Result::Success.new(input) }
    )
  }

  Proxy.default = -> input { Dry::Monads::Result::Failure.new(Errors.general_error("The model is not in the list", self.class)) }

  Execute = -> input { Proxy[input[:model]].(input) }
end
