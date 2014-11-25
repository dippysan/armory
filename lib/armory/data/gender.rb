require 'armory/identity'
require 'memoizable'

module Armory
  module Data
    class Gender < Armory::Identity
      include Memoizable

      MALE = 0
      FEMALE = 1

      def name
          male? ? "Male" : "Female"
      end
      memoize :name

      def male?
        @attrs[:id]==MALE
      end

      def female?
        @attrs[:id]==FEMALE
      end
      
    end
  end
end

