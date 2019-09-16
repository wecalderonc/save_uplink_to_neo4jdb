require 'dry/transaction/operation'
require './app/models/alarm.rb'
require './lib/errors.rb'

class SaveUplinks::AlarmTypes::Validate
  include Dry::Transaction::Operation

  def call(input)
    alarm = input[:alarm]

    if alarm.valid?
      Success input 
    else
      Failure Errors.general_error(alarm.errors.messages, self.class)
    end
  end
end
