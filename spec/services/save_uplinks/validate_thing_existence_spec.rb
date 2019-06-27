require './config/application.rb'
require './app/services/save_uplinks/validate_thing_existence.rb'

RSpec.describe SaveUplinks::ValidateThingExistence do

  describe "#call" do
    let(:thing) { create(:thing) }
    let(:input)  {
      {
        params:{
          "state":{
            "reported":{
              "device": thing.name
            }
          }
        }
      }
    }

    context "When the device reported from sigfox doesn't exist" do
      it "Should return a Failure response" do
        input = {
          params: {
            "state":{
              "reported":{
                "device":"X-DEVICE"
              }
            }
          }
        }
        response = subject.call(input)

        expect(response).to be_failure
        expect(response.failure[:error]).to eq("Device doesn't exist in BD")
      end
    end

    context "When the device reported from sigfox ,EXIST" do
      it "Should return a success response" do
        response = subject.call(input)

        expect(response).to be_success
      end
    end

  end
end
