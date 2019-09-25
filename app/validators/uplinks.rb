require 'dry/validation'
require './app/validators.rb'

module Validators::Uplinks
  StateSchema = Dry::Validation.Schema do
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
end
