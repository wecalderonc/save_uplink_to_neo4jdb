require './config/application.rb'
require './app/services/save_uplinks/build_uplink.rb'

RSpec.describe SaveUplinks::BuildUplink do

  describe "#call" do
    let(:thing) { create(:thing) }
    let(:input)  { {
      params: {
        "state": {
          "reported": {
            "device":"2BEE81",
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
      },
      thing: thing
    } }

    context "The input is valid" do
      it "Should return a Success response" do
        response = subject.call(input)

        expect(response).to be_success
      end
    end

    context "When the long doesn't exist" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:lng] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Uplink can't be build, not valid, params incomplete")
      end
    end

    context "When the lat doesn't exist" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:lat] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Uplink can't be build, not valid, params incomplete")
      end
    end

    context "When the snr doesn't exist" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:snr] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Uplink can't be build, not valid, params incomplete")
      end
    end

    context "When the avgSnr doesn't exist" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:avgSnr] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Uplink can't be build, not valid, params incomplete")
      end
    end

    context "When the seqNumber doesn't exist" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:seqNumber] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Uplink can't be build, not valid, params incomplete")
      end
    end

    context "When the station doesn't exist" do
      it "Should return a Failure response" do
        input[:params][:state][:reported][:station] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Uplink can't be build, not valid, params incomplete")
      end
    end
  end
end
