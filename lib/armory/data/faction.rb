require 'armory/identity'
require 'memoizable'

module Armory
  module Data
    class Faction < Armory::Identity
      include Memoizable

      ALLIANCE = 0
      HORDE = 1

      def name
          alliance? ? "Alliance" : "Horde"
      end
      memoize :name

      def horde?
        @attrs[:id]==HORDE
      end
      memoize :horde?

      def alliance?
        @attrs[:id]==ALLIANCE
      end
      memoize :alliance?

    end
  end
end

