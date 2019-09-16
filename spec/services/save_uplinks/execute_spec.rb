require './config/application.rb'

RSpec.describe SaveUplinks::Execute do

  describe "#call" do
    let(:thing) { create(:thing) }

    let(:input)  {
      {
        "state": {
          "reported": {
            "device": thing.name,
            "data":"00670430080670200001ascd",
            "time":"1548277798",
            "snr":"16.32",
            "station":"146A",
            "avgSnr":"18.47",
            "lat":"5.0",
            "lng":"-74.0",
            "rssi":"-111.00",
            "seqNumber":"77"
          }
        }
      }
    }

    context "When all the operations are successful" do
      it "Should return a Success response" do
        response = subject.(input)

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
