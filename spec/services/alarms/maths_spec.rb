require './config/application.rb'
require './app/services/alarms/maths.rb'

RSpec.describe Alarms::Maths do
  let(:last_accumulator) { create(:accumulator, uplink: uplink) }
  let(:uplink) {create(:uplink, accumulator: current_accumulator)}
  let(:current_accumulator) { create(:accumulator) }
  let(:flow_per_minute) {10}

  describe "#aja" do
    it "Should return a hash" do
      response = subject.aja(last_accumulator, current_accumulator, flow_per_minute)
      expected_response = { unexpected_dump: false, imposible_consumption: false }

      expect(response).to eq(expected_response)
    end
  end
end
