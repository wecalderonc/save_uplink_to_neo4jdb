require './config/application.rb'
require './spec/spec_helper.rb'
require './app/models/sensor3.rb'

RSpec.describe Sensor3, type: :model do

  it { is_expected.to define_property :value, :String }
  it { is_expected.to have_one(:uplink).with_direction(:out) }
end
