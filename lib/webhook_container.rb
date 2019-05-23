require 'dry-container'
require 'dry-auto_inject'

class WebhookContainer
  extend Dry::Container::Mixin

  namespace "save_uplinks" do |ops|
    ops.register("validate_input")                { SaveUplinks::ValidateInput.new }
    ops.register("validate_thing_existence")      { SaveUplinks::ValidateThingExistence.new }
    ops.register("parse_data")                    { SaveUplinks::ParseData.new }
    ops.register("build_uplink")                  { SaveUplinks::BuildUplink.new }
    ops.register("create_uplink")                 { SaveUplinks::CreateUplink.new }
    ops.register("save_messages_separated_in_db") { SaveUplinks::SaveMessagesSeparatedInDB.new }
  end

end

