require './config/application.rb'
require './app/services/save_uplinks.rb'

RSpec.describe SaveUplinks do

  describe "#call" do
    let!(:thing) { build(:thing) }
    let(:input)  {
      {
        params: {
          "state": {
            "reported": {
              "device":"2BEE82",
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
    }

    context "When all the operations are successful" do
      it "Should return a Success response" do
        response = subject.execute(input)

        expect(response).to be_success
      end
    end

    context "When the 'validate_input' operation fails" do
      it "Should return a Failure response" do
        input[:params].delete(:state)
        response = subject.execute(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq({:params=>{:state=>["is missing"]}})
      end
    end

    context "When the 'validate_input' operation fails" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:lng] = nil
        response = subject.execute(input)

        expect(response).to be_failure
        expect(response.failure[:error][:params][:state][:reported][:lng]).to eq(["must be filled"])
      end
    end

    context "When the 'validate_thing_existence' operation fails" do
      it "Should return a Failure response" do

        input[:params][:state][:reported][:device] = "nonexistencedevice"
        response = subject.execute(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Device doesn't exist in BD")
      end
    end

    context "When the 'validate_thing_existence' operation fails" do
      it "Should return a Failure response" do

        input[:params][:state][:reported][:data] = "123"
        response = subject.execute(input)

        expect(response).to be_failure
        expect(response.failure[:error][:params][:state][:reported][:data]).to eq(["length must be 24"])
      end
    end
  end
end
