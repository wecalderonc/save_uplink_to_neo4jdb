http_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new('http://neo4j:rompale@ec2-34-218-234-17.us-west-2.compute.amazonaws.com:7474')
neo4j_session = Neo4j::Core::CypherSession.new(http_adaptor)
Neo4j::ActiveBase.current_session = neo4j_session

# thing = Thing.create(name: "test3", time: "time")

