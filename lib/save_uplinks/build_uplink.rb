require 'dry/transaction/operation'

#Build the UPLINK objetc and validates for the saving in db
class SaveUplinks::BuildUplink
  include Dry::Transaction::Operation

  def call(input)
    reported = input[:params][:state][:reported]
    uplink_params = build_uplink(reported, input[:thing])
    uplink = "TODO UPLINK CREATE WITH NEO4J"
    if uplink #VALID?
      Success input.merge(uplink: uplink)
    else
      Failure Error.general_error("Uplink can't be build", self.class)
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
      field[:thing] = thing
      field.delete(:device)
    end
  end
end
