require 'armory/meta_methods'
require 'armory/enumerable'
require 'memoizable'

module Armory
  class Character::Talents < Armory::MetaMethods
    # include Enumerable

    attr_reader :calcTalent, :calcSpec, :calcGlyph
    alias_method :calc_talent, :calcTalent
    alias_method :calc_spec, :calcSpec
    alias_method :calc_glyph, :calcGlyph
    predicate_attr_reader :selected

    object_attr_reader_as_array :'Data::Talent', :talents
    object_attr_reader :'Character::Glyphs', :glyphs
    object_attr_reader :'Data::Spec', :spec

  end
end




