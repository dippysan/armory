require 'memoizable'
require 'armory/identity'
require 'armory/meta_methods'
require 'armory/timestamp'

CLASS_HUNTER = 3

module Armory
  module Data
    class ToonClass < Armory::Identity
      include Memoizable

      # For talent_data
      attr_reader :class
      alias_method :classname, :class
      remove_method :class  # Can't use class as interferes with Equalizer's class testing

      object_attr_reader_as_array :'Armory::Data::Glyph', :glyphs
      object_attr_reader_as_array :'Armory::Data::Spec', :specs
      object_attr_reader_as_array :'Armory::Data::Spec', :petSpecs, method_alias: :pet_specs

      # For Character.class
      attr_reader :mask, :powerType
      alias_method :power_type, :powerType

      def name
        # Return class name regardless if initialized via attrs[:class] (talent_data) or attrs[:name] (character)
        attrs[:name] || classname
      end

      def talents
        @talents
      end
      memoize :talents

      def initialize(attrs = {})
        super

        # Map all elements of multi-dimensional array into Armory::Data::Talent classes
        @talents = @attrs.fetch(:talents,[]).map do |tier|
          tier.map do |column|
            column.map do |spec|
              Armory::Data::Talent.new(spec)
            end
          end
        end

      end

    end
  end
end
