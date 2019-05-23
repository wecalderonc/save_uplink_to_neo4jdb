require 'dry/transaction/operation'
require './lib/errors.rb'

#Valida datos que vienen en el payload enviado por los dispositivos vía sigfox
class Webhooks::SaveUplinks::ValidateInput
  include Dry::Transaction::Operation

  def call(input)
    result = validation_schema.(input.to_h)
    if result.success?
      Success input
    else
      Failure Errors.general_error(result.errors, self.class)
    end
  end

  private

  STATE_SCHEMA = Dry::Validation.Schema do
    required(:state).schema do
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
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:params).schema(STATE_SCHEMA)
    end
  end
end
