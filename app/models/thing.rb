require_relative 'application_record.rb'

class Thing < ApplicationRecord

  property :name, type: String

  validates :name, presence: true

  has_many :out, :uplinks_created, type: :UPLINK_CREATED, model_class: :Uplink
end
