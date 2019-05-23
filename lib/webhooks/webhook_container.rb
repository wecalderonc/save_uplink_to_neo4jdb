require 'dry-container'
require 'dry-auto_inject'

class Webhooks::WebhookContainer
  extend Dry::Container::Mixin

  namespace "save_uplinks" do |ops|
    ops.register("validate_input")                { Webhooks::SaveUplinks::ValidateInput.new }
    ops.register("validate_thing_existence")      { Webhooks::SaveUplinks::ValidateThingExistence.new }
    ops.register("parse_data")                    { Webhooks::SaveUplinks::ParseData.new }
    ops.register("build_uplink")                  { Webhooks::SaveUplinks::BuildUplink.new }
    ops.register("create_uplink")                 { Webhooks::SaveUplinks::CreateUplink.new }
    ops.register("save_messages_separated_in_db") { Webhooks::SaveUplinks::SaveMessagesSeparatedInDB.new }
  end

end

