require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Character::Achievements::Criteria < Armory::MetaMethods
    include Equalizer.new(:id)

    attr_reader :id, :quantity

    def timestamp
      Time.at(@attrs[:timestamp]/1000) unless @attrs[:timestamp].nil?
    end
    memoize :timestamp
    alias_method :completed_timestamp, :timestamp

    def created
      Time.at(@attrs[:created]/1000) unless @attrs[:created].nil?
    end
    memoize :created
    alias_method :created_timestamp, :created



  end
end
