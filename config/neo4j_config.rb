require 'dotenv'
ENV['APP_ENV'] ||= "test"

Dotenv.load(
  File.expand_path("../../.env.#{ENV['APP_ENV']}", __FILE__))

url = "http://#{ENV['NEO4J_USERNAME']}:#{ENV['NEO4J_PASSWORD']}@#{ENV['NEO4J_SERVER']}"
http_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new(url)
neo4j_session = Neo4j::Core::CypherSession.new(http_adaptor)
Neo4j::ActiveBase.current_session = neo4j_session

