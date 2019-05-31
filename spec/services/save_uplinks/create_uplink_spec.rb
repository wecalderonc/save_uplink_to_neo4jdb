require './config/application.rb'
require './app/services/save_uplinks/create_uplink.rb'

RSpec.describe SaveUplinks::CreateUplink do

  describe "#call" do
    let(:thing) { build(:thing) }
    let(:uplink) { build(:uplink) }
    let(:input)  {
      {
        params:
        {
          "state":
          {
            "reported":
            {
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
        thing: thing,
        uplink: uplink
      }
    }

    context "The input is valid" do
      it "Should return a Success response" do
        response = subject.call(input)

        expect(response).to be_success
      end
    end

    context "When the data in Uplink.new fails" do
      it "Should return a Failure response" do
        input[:uplink][:data] = nil
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq(:data => ["can't be blank"])
      end
    end
  end
end
