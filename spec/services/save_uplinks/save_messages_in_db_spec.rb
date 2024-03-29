require './config/application.rb'
require './app/services/save_uplinks/save_messages_in_db.rb'

RSpec.describe SaveUplinks::SaveMessagesInDb do

  describe "#call" do
    let(:thing) { build(:thing) }
    let(:uplink) { build(:uplink) }
    let(:input)  {
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
        },
        thing: thing,
        uplink: uplink,
        new_messages: ["a111","9aaaa","3333","f444"]
      }
    }

    context "Success response, everything was save in the db" do
      it "Should return a Success response" do
        response = subject.call(input)

        expected_response =

        [
          {
            :bit_descriptor=>"a",
            :message=>"Messages Saved Successfully",
          },
          {
            :bit_descriptor=>"9",
            :message=>"Messages Saved Successfully",
          },
          {
            :bit_descriptor=>"3",
            :message=>"Messages Saved Successfully",
          },
          {
            :bit_descriptor=>"f",
            :message=>"Messages Saved Successfully",
          }]


        expect(response).to be_success
        expect(response.success[:results]).to eq(expected_response)
      end
    end

    context "One value empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a111","9","3aaaa","f444"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(4)
        expect(response.success[:results][1][:error]).to eq({:value=>["can't be blank"]})
      end
    end

    context "Two value are empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a111","9","30","f444"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(4)
        expect(response.success[:results][1][:error]).to eq({:value=>["can't be blank"]})
      end
    end

    context "Three values are empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a111","9","30","5"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(4)
        expect(response.success[:results][1][:error]).to eq({:value=>["can't be blank"]})
      end
    end

    context "All values are empty in a string in the new_message input" do
      it "Should return errors" do
        input[:new_messages] = ["a","9","30","8"]
        response = subject.call(input)

        expect(response).to be_success
        expect(response.success[:results].size).to eq(4)
        expect(response.success[:results][0][:error]).to eq({:value=>["can't be blank"]})
        expect(response.success[:results][1][:error]).to eq({:value=>["can't be blank"]})
      end
    end
  end
end
