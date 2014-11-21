require 'equalizer'
require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  class Character::Achievements::Criteria < Armory::MetaMethods
    include Equalizer.new(:id)
    include Timestamp

    attr_reader :id, :quantity, :description, :orderIndex, :max
    alias_method :order_index, :orderIndex

    alias_method :completed_timestamp, :timestamp

    def created
      convert_to_time(@attrs[:created])
    end
    memoize :created
    alias_method :created_timestamp, :created

  end
end
