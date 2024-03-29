require './lib/errors.rb'
require 'dry/transaction/operation'

class SaveUplinks::ValidateThingExistence
  include Dry::Transaction::Operation

  def call(input)
    device = input[:state][:reported][:device]
    thing = Thing.find_by(name: device)
    if thing.present?
      Success input.merge(thing: thing)
    else
      Failure Errors.general_error("Device doesn't exist in BD", self.class)
    end
  end
end
