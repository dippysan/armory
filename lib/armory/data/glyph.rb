require 'armory/identity.rb'

module Armory
  module Data
    class Glyph < Armory::MetaMethods
      include Equalizer.new(:glyph)

      MAJOR = 0
      MINOR = 1

      attr_reader :glyph, :name, :icon, :typeId
      alias_method :type_id, :typeId
      alias_method :id, :glyph

      def major?
        type_id == MAJOR
      end

      def minor?
        type_id == MINOR
      end

      object_attr_reader :Item, :item, target_alias: :id, include_keys: [IncludeKey.new(:name), IncludeKey.new(:icon)]

    end
  end
end
