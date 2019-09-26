require './app/services/alarms/create/classify.rb'
require './app/services/alarms/create/persist.rb'
require './app/services/alarms/create/generate_alarm.rb'

module Alarms::Create
  _, BaseTx = Common::TxMasterBuilder.new do
    step :validate_input,        with: Common::Operations::Validator.(:create, :alarm)
    step :classify,              with: Alarms::Create::Classify.new
    step :generate_alarm,        with: Alarms::Create::GenerateAlarm.new
    step :persist_alarm_type,    with: Alarms::Create::Persist.new
  end.Do

  Proxy = {
    accumulator:    BaseTx.new,
    battery_level:  BaseTx.new,
    alarm:          BaseTx.new(
      generate_alarm: -> input { Dry::Monads::Result::Success.new(input) }
    )
  }

  error = Errors.general_error("The model is not in the list", self.class)
  Proxy.default = -> input { Dry::Monads::Result::Failure.new(error) }

  Execute = -> input { Proxy[input[:model]].(input) }
end
