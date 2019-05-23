require 'dry/transaction/operation'

#Guarda en DB todo el UPLINK de un dispositivo.
class Webhooks::SaveUplinks::CreateUplink
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
