require './lambda_function.rb'
require './config/application.rb'


RSpec.describe Handler do
  let(:subject)     { described_class }
  let(:accumulator) { create(:accumulator, value: "00000000")}
  let(:thing)       { accumulator.uplink.thing }
  let(:context)     { {} }
  let(:event)       {
    {
      "state": {
          "reported": {
            "device":thing.name,
            "data":"00674000130670200001aaaa",
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

    # {
    #   "state"=>
    #   {
    #     "reported"=>
    #     {
    #       "device"=>"3E3BF2",
    #       "data"=>"00000000030051200001001d",
    #       "time"=>"1574955216",
    #       "snr"=>"6.00",
    #       "station"=>"116B",
    #       "avgSnr"=>"20.35",
    #       "lat"=>"5.0",
    #       "lng"=>"-74.0",
    #       "rssi"=>"-123.00",
    #       "seqNumber"=>"62"
    #     }
    #   }
    # }
  }

  describe "#lambda_handler" do

    context "When all operations are successfull" do
      it "Should save new messages and uplink" do
        response = subject.lambda_handler(event: event, context: context)

        expected_response =
          [
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "3"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "4"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "2"
            }
          ]

        expect(response[:results]).to eq(expected_response)
      end
    end

    context "When all operations are successfull messages 5 6 7 8" do

      let(:event)   {
          {
            "state": {
                "reported": {
                  "device":thing.name,
                  "data":"00678000170670600005ascd",
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

      it "Should save new messages and uplink" do
        response = subject.lambda_handler(event: event, context: context)

        expected_response =
          [
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "5"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "6"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "7"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "8"
            }
          ]

        expect(response[:results]).to eq(expected_response)
      end
    end

    context "When all operations are successfull messages 9 a b c" do

      let(:event)   {
          {
            "state": {
                "reported": {
                  "device":thing.name,
                  "data":"0067c0001b0670a00009ascd",
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

      it "Should save new messages and uplink" do
        response = subject.lambda_handler(event: event, context: context)

        expected_response =
          [
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "9"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "a"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "b"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "c"
            }
          ]

        expect(response[:results]).to eq(expected_response)
      end
    end

    context "When all operations are successfull messages 5 6 7 8" do

      let(:event)   {
          {
            "state": {
                "reported": {
                  "device":thing.name,
                  "data":"00674000130670e0000dascd",
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

      it "Should save new messages and uplink" do
        response = subject.lambda_handler(event: event, context: context)

        expected_response =
          [
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "d"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "e"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "3"
            },
            {
              message: "Messages Saved Successfully",
              bit_descriptor: "4"
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
