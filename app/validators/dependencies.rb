require './app/validators/uplinks.rb'
require './app/validators/alarms.rb'

module Validators
  Dependencies = {
    get_state: {
      uplink:             Validators::Uplinks::StateSchema
    },

    create: {
      alarm:              Validators::Alarms::CreateSchema
    }
}
end
