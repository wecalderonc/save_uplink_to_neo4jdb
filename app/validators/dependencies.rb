require './app/validators/uplinks.rb'
require './app/validators/alarm_types.rb'

module Validators
  Dependencies = {
    get_state: {
      uplink:                  Validators::Uplinks::StateSchema
    },

    create: {
    alarm_type:                Validators::AlarmTypes::CreateSchema
    }
}
end
