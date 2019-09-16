require 'dry/transaction/operation'

class Alarms::Classify::Save
  include Dry::Transaction::Operation

  def call(input)
    name = input[:hardware_type]
    last_digit = input[:last_digit]

    AlarmType.create(name: name, value: last_digit, type: :hardware, alarm: self)
  end
end
