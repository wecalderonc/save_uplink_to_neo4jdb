require 'dry/validation'
require './app/validators/dependencies.rb'
require './app/validators.rb'

module Validators::AlarmTypes
  CreateSchema = Dry::Validation.Schema do
    required(:type).filled(type?: String)

    validate(valid_alarm: :alarm) do |alarm|
      alarm.valid?
    end
  end
end
