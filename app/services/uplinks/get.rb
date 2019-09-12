require 'dry/transaction/operation'

class Uplinks::Get
  include Dry::Transaction::Operation

  def call(input)
    thing = input[:thing]
    last_uplink = thing.last_uplinks

    if last_uplink.present?
      Success input.merge(last_uplink: last_uplink)
    else
      Failure Errors.general_error("The thing does not have uplinks", self.class)
    end
  end
end
