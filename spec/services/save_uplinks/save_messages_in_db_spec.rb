
RSpec.describe SaveUplinks::SaveMessagesInDB do

  describe "#call" do
    let!(:thing) { create(:thing) }
    let(:uplink) { create(:uplink) }
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
        uplink: uplink,
        messages: [1111,2222,3333,4444]
      }
    }

    context "The input is valid" do
      it "Should return a Success response" do
        response = subject.call(input)

        expect(response).to be_success
      end
    end
  end
end
