require 'dry/transaction/operation'

#Save in db all the uplink of the devices.
class SaveUplinks::CreateUplink
  include Dry::Transaction::Operation

  def call(input)
    uplink = input[:uplink]
    if uplink #.SAVE, TODO WITH NEO4J
      Success input
    else
      Failure Error.general_error("Uplink can't be save in DB", self.class)
    end
  end
end
