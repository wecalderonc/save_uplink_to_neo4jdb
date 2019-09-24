require './config/application.rb'
require './app/services/alarms/create/execute.rb'


RSpec.describe Alarms::Create::Execute do

  describe "#call" do
    let(:alarm) { build(:alarm) }
    let(:input) {
      {
        object: alarm,
        type: "hardware",
        model: :alarm
      }
    }

    context "When all the operations are successful" do
      it "Should return a Success response" do
        response = subject.(input)

        expect(response).to be_success
      end
    end

    context "When the validation step fails" do
      it "Should return a Failure response response" do
        input.delete(:type)

        p response = subject.(input)
        expected_response = nil

        expect(response).to be_failure
        expect(response.failure[:message]).to eq(expected_response)
      end
    end
  end
end
