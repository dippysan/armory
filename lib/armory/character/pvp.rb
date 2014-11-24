require 'armory/meta_methods'
require 'armory/enumerable'


module Armory
  class Character::PvP < Armory::MetaMethods
    include Enumerable

    ARENA_ORDER_SLUG = %w(2v2 3v3 5v5 rbg unknown)
    ARENA_ORDER_METHOD = %w(v2 v3 v5 rbg unknown)

    object_attr_reader :'Data::ArenaBracket', :ARENA_BRACKET_2v2, method_alias: :arena_bracket_2v2
    object_attr_reader :'Data::ArenaBracket', :ARENA_BRACKET_3v3, method_alias: :arena_bracket_3v3
    object_attr_reader :'Data::ArenaBracket', :ARENA_BRACKET_5v5, method_alias: :arena_bracket_5v5
    object_attr_reader :'Data::ArenaBracket', :ARENA_BRACKET_RBG, method_alias: :arena_bracket_rbg
    object_attr_reader :'Data::ArenaBracket', :UNKNOWN, method_alias: :unknown
    alias_method :v2, :arena_bracket_2v2
    alias_method :v3, :arena_bracket_3v3
    alias_method :v5, :arena_bracket_5v5
    alias_method :rbg, :arena_bracket_rbg

    def initialize(attrs = {})
      super

      @collection = ARENA_ORDER_METHOD.map do |meth|
        self.send(meth)
      end
    end


  end
end




