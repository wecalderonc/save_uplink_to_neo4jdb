require_relative 'application_record.rb'

class Accumulator < ApplicationRecord
  
  property :value, type: String

  validates :value, presence: true

  has_one :out, :uplink, type: :BELONGS_TO

end
