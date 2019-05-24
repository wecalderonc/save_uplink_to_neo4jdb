require 'dry-container'
require 'dry-auto_inject'

class Container
  extend Dry::Container::Mixin

  namespace "save_uplinks" do |ops|
    ops.register("validate_input")                { SaveUplinks::ValidateInput.new }
    ops.register("validate_thing_existence")      { SaveUplinks::ValidateThingExistence.new }
  end

end

