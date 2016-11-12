require 'armory/identity.rb'
require 'armory/enumerable'

module Armory
  module Data
    class Raid < Armory::Identity
      include Armory::Enumerable

      attr_reader :name, :lfr, :normal, :heroic, :mythic

      def bosses
        @collection
      end
      memoize :bosses

      def bosses_hash
        @collection_hash
      end
      memoize :bosses_hash

      def initialize(attrs = {})
        super

        @collection = attrs.fetch(:bosses, []).collect do |data|
          Armory::Data::RaidBoss.new(data)
        end
        # Create hash keyed on achievement id
        @collection_hash = Hash[@collection.map {|a| [ a.id, a ] }]
        
      end

    end
  end
end
