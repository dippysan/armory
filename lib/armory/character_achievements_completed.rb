require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Character::Achievements::Completed < Armory::MetaMethods
    include Equalizer.new(:id)

    attr_reader :id

    def timestamp
      Time.at(@attrs[:timestamp]/1000) unless @attrs[:timestamp].nil?
    end
    memoize :timestamp
    alias_method :completed_timestamp, :timestamp



  end
end
