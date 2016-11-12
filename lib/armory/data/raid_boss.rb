require 'armory/identity.rb'
require 'armory/enumerable'
require 'armory/timestamp'

module Armory
  module Data
    class RaidBoss < Armory::Identity
      include Armory::Enumerable
      include Timestamp

      attr_reader :id, :name
      attr_reader :lfrKills, :lfrTimestamp
      alias_method :lfr_kills, :lfrKills
      attr_reader :normalKills, :normalTimestamp
      alias_method :normal_kills, :normalKills
      attr_reader :heroicKills, :heroicTimestamp
      alias_method :heroic_kills, :heroicKills
      attr_reader :mythicKills, :mythicTimestamp
      alias_method :mythic_kills, :mythicKills

      def lfr_timestamp
        convert_to_time(@attrs[:lfrTimestamp])
      end
      memoize :lfr_timestamp

      def normal_timestamp
        convert_to_time(@attrs[:normalTimestamp])
      end
      memoize :normal_timestamp

      def heroic_timestamp
        convert_to_time(@attrs[:heroicTimestamp])
      end
      memoize :heroic_timestamp

      def mythic_timestamp
        convert_to_time(@attrs[:mythicTimestamp])
      end
      memoize :mythic_timestamp


    end
  end
end
