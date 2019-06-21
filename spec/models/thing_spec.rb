require './config/application.rb'
require './spec/spec_helper.rb'
require './app/models/thing.rb'

RSpec.describe Thing, type: :model do
  it { is_expected.to define_property :name, :String }
  it { is_expected.to have_many(:uplinks).with_direction(:out) }
end
