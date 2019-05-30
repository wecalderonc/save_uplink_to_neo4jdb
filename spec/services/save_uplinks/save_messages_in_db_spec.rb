require './config/application.rb'
require './app/services/save_uplinks/save_messages_in_db.rb'

RSpec.describe SaveUplinks::SaveMessagesInDB do

  describe "#call" do
    let(:thing) { create(:thing) }
    let(:uplink) { create(:uplink) }
    let(:input)  {
      {
        params:
        {
          "state":
          {
            "reported":
            {
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
        },
        thing: thing,
        uplink: uplink,
        new_messages: ["a111","9aaaa","3333","f444"]
      }
    }

    context "Success response, everything was save in the db" do
      it "Should return a Success response" do
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results]).to eq([])
      end
    end

    context "One value empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a111","9","3aaaa","f444"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(1)
        expect(response.success[:results][0][:error]).to eq({:value=>["can't be blank"]})
      end
    end

    context "Two value are empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a111","9","3","f444"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(2)
        expect(response.success[:results][0][:error]).to eq({:value=>["can't be blank"]})
      end
    end

    context "Three values are empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a111","9","3","5"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(3)
        expect(response.success[:results][0][:error]).to eq({:value=>["can't be blank"]})
      end
    end

    context "All values are empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a","9","3","8"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(4)
        expect(response.success[:results][0][:error]).to eq({:value=>["can't be blank"]})
      end
    end
  end
end
