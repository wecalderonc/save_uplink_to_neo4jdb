require 'dry/transaction/operation'

class Things::Downlinks::Get
  include Dry::Transaction::Operation

  def call(input)
    thing = input[:thing]
    #TODO thing.last_downlink
    last_downlink = "0"

    if last_downlink.present?
      Success input.merge(last_downlink: last_downlink)
    else
      Failure Errors.general_error("The thing does not have downlinks", self.class)
    end
  end
end
