require './lambda_function.rb'

RSpec.describe Handler  do

  let(:event)  {
    {
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
      }
    }
  }

  let(:context) { {} }

  # subject = described_class.new

  it 'responds successfully' do

      response = subject.lambda_handler(event: event, context: context)

      expect(response).to include(body: "{\"id\":\"41480D\"}")
  end
end
