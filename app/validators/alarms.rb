require 'dry/validation'
require './app/validators/dependencies.rb'
require './app/validators.rb'

module Validators::Alarms
  CreateSchema = Dry::Validation.Schema do
    required(:type).filled(type?: String) #revisar quee ste incluido en el array
    required(:model).filled(type?: Symbol)

    validate(valid_object: :object) do |object|
      object.valid?
    end
  end
end
