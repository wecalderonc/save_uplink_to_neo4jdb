require './lambda_function.rb'
require './config/application.rb'


RSpec.describe Handler do
  let(:subject) { described_class }
  let(:thing)   { create(:thing) }
  let(:context) { {} }
  let(:event)   {
    {
      "state": {
          "reported": {
            "device":thing.name,
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

  describe "#lambda_handler" do

    context "When all operations are successfull" do
      it "Should save new messages and uplink" do
        response = subject.lambda_handler(event: event, context: context)

        expected_response =
          [
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "8"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "0"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "2"
            }
          ]

        expect(response[:results]).to eq(expected_response)
      end
    end

    context "When the 'validate_input' operation fails" do
      it "Should return a Failure response" do
        event.delete(:state)
        response = subject.lambda_handler(event: event, context: context)

        expect(response[:error]).to eq({:state=>["is missing"]})
      end
    end

    context "When the 'validate_input' operation fails" do
      it "Should return a Failure response" do
        event[:state][:reported][:lng] = nil
        response = subject.lambda_handler(event: event, context: context)

        expect(response[:error][:state][:reported][:lng]).to eq(["must be filled"])
      end
    end

    context "When the 'validate_thing_existence' operation fails" do
      it "Should return a Failure response" do

        event[:state][:reported][:device] = "nonexistencedevice"
        response = subject.lambda_handler(event: event, context: context)

        expect(response[:error]).to eq("Device doesn't exist in BD")
      end
    end

    context "When the 'validate_thing_existence' operation fails" do
      it "Should return a Failure response" do

        event[:state][:reported][:data] = "123"
        response = subject.lambda_handler(event: event, context: context)

        expect(response[:error][:state][:reported][:data]).to eq(["length must be 24"])
      end
    end
  end
end
