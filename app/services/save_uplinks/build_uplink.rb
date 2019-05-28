require 'dry/transaction/operation'
require './app/models/uplink.rb'
require './lib/errors.rb'

#Build uplink instance
class SaveUplinks::BuildUplink
  include Dry::Transaction::Operation

  def call(input)
    reported = input[:params][:state][:reported]
    uplink_params = build_uplink(reported, input[:thing])
    uplink = Uplink.new(uplink_params)
    if uplink.valid?
      Success input.merge(uplink: uplink)
    else
      Failure Errors.general_error(uplink.errors.messages, self.class)
    end
  end

  private

  def build_uplink(uplink_data, thing)
    uplink_data.tap do |field|
      field[:long] = uplink_data.delete(:lng)
      field[:avgsnr] =  uplink_data.delete(:avgSnr)
      field[:seqnumber] = uplink_data.delete(:seqNumber)
      field[:sec_downlinks] = uplink_data[:data][0]
      field[:sec_uplinks] = uplink_data[:data][1..3]
      field[:uplinks_created] = thing
      field.delete(:device)
    end
  end
end
