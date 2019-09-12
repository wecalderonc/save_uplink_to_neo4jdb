require './app/validators/uplinks.rb'

module Validators
  Dependencies = {
    get_state: {
      uplink:                               Validators::Uplinks::StateSchema
    }
  }
end
