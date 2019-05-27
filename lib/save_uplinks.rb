require_relative 'container.rb'

#Transaction for save uplinks in neo4jdb
class SaveUplinks
  include Dry::Transaction(container: Container)

  step :validate_input,                 with: "save_uplinks.validate_input"
  step :validate_thing_existence,       with: "save_uplinks.validate_thing_existence"

  def execute(input)
    self.call(input)
  end
end


