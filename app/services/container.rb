require 'dry-container'
require 'dry-auto_inject'

#Container for SaveUplink transaction
class Container
  extend Dry::Container::Mixin

  namespace "save_uplinks" do |ops|
    ops.register("validate_input")                { SaveUplinks::ValidateInput.new }
    ops.register("validate_thing_existence")      { SaveUplinks::ValidateThingExistence.new }
    ops.register("build_uplink")                  { SaveUplinks::BuildUplink.new }
    ops.register("create_uplink")                 { SaveUplinks::CreateUplink.new }
  end

end

