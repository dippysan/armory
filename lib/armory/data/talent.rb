require 'equalizer'

module Armory
  module Data
    class Talent < Armory::MetaMethods
      include Equalizer.new(:tier, :column)

      attr_reader :tier, :column
      object_attr_reader :'Data::Spell', :spell
      object_attr_reader :'Armory::Data::Spec', :spec

    end
  end
end
