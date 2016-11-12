require 'armory/identity.rb'

module Armory
  module Data
    class GemInfo < Armory::MetaMethods

      attr_reader :minItemLevel
      alias_method :min_item_level, :minItemLevel

      object_attr_reader :'Data::GemBonus', :bonus

      def type
        @attrs.fetch(:type,{}).fetch(:type,nil)
      end
      memoize :type

      def is_relic?
        @attrs.fetch(:bonus,{}).fetch(:name,nil) == "Relic Enhancement"
      end
      memoize :is_relic?

    end
  end
end
