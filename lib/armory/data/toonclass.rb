require 'memoizable'
require 'armory/identity'
require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  class Armory::Data; end
  class Armory::Data::ToonClass < Armory::Identity
    include Memoizable

    attr_reader :class
    alias_method :name, :class
    alias_method :classname, :class
    remove_method :class  # Can't use class as interferes with Equalizer's class testing

    object_attr_reader_as_array :'Armory::Data::Glyph', :glyphs
    object_attr_reader_as_array :'Armory::Data::Spec', :specs
    object_attr_reader_as_array :'Armory::Data::Spec', :petSpecs, :pet_specs

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
          column.collect.with_index do |spec,i|
            # add spec to talent
            spec = spec.dup
            spec[:spec] = @attrs[:specs][i]
            spec = Armory::Data::Talent.new(spec)
            @talents_flatten << spec
            spec
          end
        end
      end

    end
  end
end
