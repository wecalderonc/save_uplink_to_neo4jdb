require 'dry/validation'
require './app/validators/dependencies.rb'
require './app/validators.rb'

module Validators::AlarmTypes
  CreateSchema = Dry::Validation.Schema do
    required(:name).filled(type?: String)
    required(:value).filled(type?: Integer)
    required(:type).filled(type?: String)
  end
end
