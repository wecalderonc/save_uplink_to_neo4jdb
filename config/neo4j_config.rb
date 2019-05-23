url = "http://#{ENV['neo4j_username']}:#{ENV['neo4j_password']}@#{ENV['neo4j_server']}"
http_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new(url)
neo4j_session = Neo4j::Core::CypherSession.new(http_adaptor)
Neo4j::ActiveBase.current_session = neo4j_session

