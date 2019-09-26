require 'dry/validation'
require './app/models/alarm_type.rb'

module Validators::Alarms
  CreateSchema = Dry::Validation.Schema do
    configure { config.messages_file = "config/locales/en.yml" }

    required(:type).filled(type?: Symbol, included_in?: AlarmType::TYPES)
    required(:model).filled(type?: Symbol)
    required(:object).filled

    validate(valid_object: :object) do |object|
      object.valid?
    end
  end
end
