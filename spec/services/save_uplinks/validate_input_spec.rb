require './config/application.rb'
require './app/services/save_uplinks/validate_input.rb'

RSpec.describe SaveUplinks::ValidateInput do

  describe "#call" do
    let(:input)  {
      {
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
      }
    }

    context "The input is valid" do
      it "Should return a Success response" do
        response = subject.call(input)

        expect(response).to be_success
      end
    end

    context "When the reported is empty" do
      it "Should return a Failure response" do
        input[:state][:reported] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the state is empty" do
      it "Should return a Failure response" do
        input[:state] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the data is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:data] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the device is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:data] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the time is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:time] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the snr is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:snr] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the station is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:station] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the avgSnr is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:avgSnr] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the lat is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:lat] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the lng is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:lng] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the rssi is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:rssi] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end

    context "When the seqNumber is empty" do
      it "Should return a Failure response" do
        input[:state][:reported][:seqNumber] = {}
        response = subject.call(input)

        expect(response).to be_failure
      end
    end
  end
end
