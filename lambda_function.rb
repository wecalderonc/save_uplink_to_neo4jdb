require './requires/index_requires.rb'

module Handler
  def self.lambda_handler(event:, context:)
    SaveUplinks.new.execute(event)
  end
end

