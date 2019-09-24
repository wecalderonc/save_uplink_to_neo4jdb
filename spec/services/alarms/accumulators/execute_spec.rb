require './config/application.rb'
require './app/services/alarms/accumulators/execute.rb'

RSpec.describe Alarms::Accumulators::Execute do
  let(:response) { response = subject.(input) }
  let(:last_accumulator) { create(:accumulator, uplink: uplink, value: 10.to_s(16)) }
  let(:uplink) { create(:uplink, time: 1568887200) }
  let(:current_accumulator) { create(:accumulator, uplink: uplink_2, value: 11.to_s(16)) }
  let(:uplink_2) { create(:uplink, time: 1568890800) }
  let(:input) {
    {
      last_accumulator: last_accumulator,
      current_accumulator: current_accumulator,
      flow_per_minute: 10
    }
  }

  describe "#equations" do
    context "There are any alarms" do
      it "Should return a hash with  both alarms in false" do
        expected_response = { unexpected_dump: false, imposible_consumption: false }

        expect(response).to be_success
        expect(response.success).to eq(expected_response)
      end
    end

    context "There are an imposible_consumption" do
      it "Should return a hash with  both alarms in true" do
        last_accumulator.update(value: 100.to_s(16))
        current_accumulator.update(value: 10000.to_s(16))


        expected_response = { unexpected_dump: false, imposible_consumption: true }

        expect(response).to be_success
        expect(response.success).to eq(expected_response)
      end
    end

    context "There are an imposible_consumption and an unexpected_dump" do
      it "Should return a hash with  both alarms in true" do
        last_accumulator.update(value: 9000.to_s(16))
        current_accumulator.update(value: 4000.to_s(16))

        expected_response = { unexpected_dump: true, imposible_consumption: true }

        expect(response).to be_success
        expect(response.success).to eq(expected_response)
      end
    end
  end
end
