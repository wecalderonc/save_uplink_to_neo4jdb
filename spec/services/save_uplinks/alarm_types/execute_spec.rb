require './config/application.rb'
require './app/services/save_uplinks/alarm_types/validate.rb'
require './app/services/save_uplinks/alarm_types/execute.rb'

RSpec.describe SaveUplinks::AlarmTypes::Execute do
  describe "#call" do
    let(:alarm) { build(:alarm) }

    let(:input) { alarm }


    context "When all the operations are successful" do
      it "Should return a Success response" do
    p  response = subject.(input)

        expect(response).to be_success
      end
    end

    context "When the 'validate_input' operation fails" do
      it "Should return a Failure response" do
        input.delete(:state)
        response = subject.(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq({:state=>["is missing"]})
      end
    end

    context "When the 'validate_input' operation fails" do
      it "Should return a Failure response" do
        input[:state][:reported][:lng] = nil
        response = subject.(input)

        expect(response).to be_failure
        expect(response.failure[:error][:state][:reported][:lng]).to eq(["must be filled"])
      end
    end

    context "When the 'validate_thing_existence' operation fails" do
      it "Should return a Failure response" do

        input[:state][:reported][:device] = "nonexistencedevice"
        response = subject.(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Device doesn't exist in BD")
      end
    end

    context "When the 'validate_thing_existence' operation fails" do
      it "Should return a Failure response" do

        input[:state][:reported][:data] = "123"
        response = subject.(input)

        expect(response).to be_failure
        expect(response.failure[:error][:state][:reported][:data]).to eq(["length must be 24"])
      end
    end
  end
end
