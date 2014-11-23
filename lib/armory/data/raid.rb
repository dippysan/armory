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

      def initialize(attrs = {})
        super

        @collection = attrs.fetch(:bosses, []).collect do |data|
          Armory::Data::RaidBoss.new(data)
        end
        
      end

    end
  end
end
