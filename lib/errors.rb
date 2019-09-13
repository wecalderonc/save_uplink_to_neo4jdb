#Errors control
module Errors
  def self.failed_request(status, message)
    { status: status, message: message }
  end

  def self.general_error(message, location, extra: {})
    { error: message, location: location, extra: extra }
  end

  def self.model_error(error, model, extra: {})
    { error: error, model: model, extra: extra }
  end
end
