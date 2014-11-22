require 'armory/identity.rb'

module Armory
  class Data; end
  class Data::Glyph < Armory::MetaMethods
    include Equalizer.new(:glyph)

    attr_reader :glyph, :item, :name, :icon, :typeId
    alias_method :type_id, :typeId
    alias_method :id, :glyph

  end
end
