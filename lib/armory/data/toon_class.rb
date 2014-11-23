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
      object_attr_reader_as_array :'Armory::Data::Spec', :petSpecs, :pet_specs

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

      def talents_flatten
        @talents_flatten
      end
      memoize :talents_flatten

      def initialize(attrs = {})
        super

        @talents_flatten = []
        @talents = @attrs.fetch(:talents,[]).collect do |tier|
          tier.collect do |column|
            column.select.with_index { |spec,i| armory_bug_remove_hunter_t6c1(spec,i) }
              .collect.with_index do |spec,i|

              # add spec to talent
              spec = spec.dup
              spec[:spec] = @attrs[:specs][i]
              spec[:spec][:id] = i
              spec = Armory::Data::Talent.new(spec)
              @talents_flatten << spec
              spec
            end
          end
        end

      end

    private
      # ARMORY BUG - returns 4 talents for hunters tier 6, when should just be three. Ignore 4th
      def armory_bug_remove_hunter_t6c1(spec,i)
        !(id == CLASS_HUNTER && spec[:tier] == 6 && spec[:column] == 1 && i == 3)
      end

    end
  end
end
