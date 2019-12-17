require_relative 'base_model.rb'

class Accumulator < BaseModel
  property :wrong_consumption, type: Boolean, default: false
end

