require 'dry/transaction/operation'
require './lib/errors.rb'

#Validate data that comes inside the payload sended from the devices.
class SaveUplinks::ValidateInput
  include Dry::Transaction::Operation

  def call(input)
    input = input.deep_symbolize_keys
    result = validation_schema.(input.to_h)
    if result.success?
      Success input
    else
      Failure Errors.general_error(result.errors, self.class)
    end
  end

  private

  STATE_SCHEMA = Dry::Validation.Schema do
    required(:reported).schema do
      required(:data).filled(:str?, size?: 24)
      required(:time).filled(:str?)
      required(:snr).filled(:str?)
      required(:station).filled(:str?)
      required(:avgSnr).filled(:str?)
      required(:lat).filled(:str?)
      required(:lng).filled(:str?)
      required(:rssi).filled(:str?)
      required(:seqNumber).filled(:str?)
    end
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state).schema(STATE_SCHEMA)
    end
  end
end
