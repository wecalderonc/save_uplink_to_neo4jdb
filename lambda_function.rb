# require 'forwardable'
require './requires/neo4j.rb'
require './requires/dry.rb'
require './lib/errors.rb'
require './models/thing.rb'
require './config/neo4j_config.rb'

require 'active_support'
ActiveSupport::Dependencies.autoload_paths = [
  'lib/',
]

module Handler
  def self.lambda_handler(event:, context:)
    SaveUplinks.new.execute(event)
  end
end

event2 =
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
context = {}
Handler.lambda_handler(event: event2, context: context)
