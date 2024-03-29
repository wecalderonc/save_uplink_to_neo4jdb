require './config/application.rb'

#Default handler for aws lambdas
module Handler
  def self.lambda_handler(event:, context:)
    event.deep_transform_keys!(&:to_sym)

    p result = SaveUplinks::Execute.new.(event)

    if result.success?
      result.success
    else
      result.failure
    end
  end
end
