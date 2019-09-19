require './config/application.rb'
require './app/services/alarms/create/execute.rb'


RSpec.describe Alarms::Create::Execute do

  describe "#call" do
    let(:alarm) { build(:alarm) }
    let(:input) {
      {
        alarm: alarm, type: "hardware"
      }
    }

    context "When all the operations are successful" do
      it "Should return a Success response" do
        response = subject.(input)

        expect(response).to be_success
      end
    end

    context "When the alarm don't have a type associated" do
      it "Should return a Failure response response" do
        input.delete(:type)

        response = subject.(input)
        expected_response = nil

        expect(response).to be_failure
        expect(response.failure[:message]).to eq(expected_response)
      end
    end
  end
end
