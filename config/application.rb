require_relative './neo4j.rb'
require_relative './dry.rb'

require 'dotenv/load'
require './config/neo4j_config.rb'

require 'active_support'
ActiveSupport::Dependencies.autoload_paths = [
  'app/services',
  'lib/',
  'spec/'
]

require './lib/errors.rb'
require './app/models/thing.rb'
