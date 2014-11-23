require 'armory/identity'
require 'memoizable'

module Armory
  module Data
    class Gender < Armory::Identity
      include Memoizable

      def name
          @attrs[:id]==0 ? "Male" : "Female"
      end
      memoize :name
      
    end
  end
end

