require 'dry/transaction/operation'
require './app/models/uplink.rb'
require './lib/errors.rb'

#Save the uplink in db
class SaveUplinks::CreateUplink
  include Dry::Transaction::Operation

  def call(input)
    uplink = input[:uplink]
    if uplink.save
      Success input
    else
      Failure Errors.general_error(uplink.errors.messages, self.class)
    end
  end
end
