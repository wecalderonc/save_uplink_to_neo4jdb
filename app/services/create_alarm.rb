require_relative 'container.rb'
require './lib/rebuild.rb'

class CreateAlarm
  include Dry::Transaction(container: Container)

  step :validate_input,                 with: "sdf"
  step :,       with: "sdjhf"

  def execute(input)
    self.call(input)
  end
end
