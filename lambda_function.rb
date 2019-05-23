# require 'forwardable'
require './requires/neo4j.rb'
require './requires/dry.rb'
require 'dotenv/load'

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

