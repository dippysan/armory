require 'armory/identity.rb'

module Armory
  module Data
    class GemInfo < Armory::MetaMethods

      attr_reader :minItemLevel
      alias_method :min_item_level, :minItemLevel

      object_attr_reader :'Data::GemBonus', :bonus

      def type
        @attrs[:type][:type]
      end
      memoize :type


    end
  end
end
