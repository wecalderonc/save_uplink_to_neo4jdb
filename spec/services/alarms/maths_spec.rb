require './config/application.rb'
require './app/services/alarms/maths.rb'

RSpec.describe Alarms::Maths do
  let(:last_accumulator) { create(:accumulator, uplink: uplink, value: 10.to_s(16)) }
  let(:uplink) { create(:uplink, time: 1568887200) }
  let(:current_accumulator) { create(:accumulator, uplink: uplink_2, value: 11.to_s(16)) }
  let(:uplink_2) { create(:uplink, time: 1568890800) }
  let(:flow_per_minute) { 10 }

  describe "#equations" do
    context "There are any alarms" do
      it "Should return a hash with  both alarms in false" do
        response = subject.equations(last_accumulator, current_accumulator, flow_per_minute)
        expected_response = { unexpected_dump: false, imposible_consumption: false }

        expect(response).to eq(expected_response)
      end
    end

    context "There are an imposible_consumption" do
      it "Should return a hash with  both alarms in true" do
        last_accumulator.update(value: 100.to_s(16))
        current_accumulator.update(value: 10000.to_s(16))

        response = subject.equations(last_accumulator, current_accumulator, flow_per_minute)
        expected_response = { unexpected_dump: false, imposible_consumption: true }

        expect(response).to eq(expected_response)
      end
    end

    context "There are an imposible_consumption and an unexpected_dump" do
      it "Should return a hash with  both alarms in true" do
        last_accumulator.update(value: 9000.to_s(16))
        current_accumulator.update(value: 4000.to_s(16))

        response = subject.equations(last_accumulator, current_accumulator, flow_per_minute)
        expected_response = { unexpected_dump: true, imposible_consumption: true }

        expect(response).to eq(expected_response)
      end
    end
  end
end
