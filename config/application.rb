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
require './app/models/accumulator.rb'
require './app/models/sensor1.rb'
require './app/models/sensor2.rb'
require './app/models/sensor3.rb'
require './app/models/sensor4.rb'
require './app/models/valve_position.rb'
require './app/models/battery_level.rb'
require './app/models/time_uplink.rb'
require './app/models/uplink_b_downlink.rb'
require './app/models/alarm.rb'
require './app/models/uplink.rb'
