require 'armory/identity.rb'
require 'equalizer'

module Armory
  module Data
    class Mount < Armory::MetaMethods
    include Equalizer.new(:item_id)

    attr_reader :name, :spellId, :creatureId, :qualityId, :icon
    alias_method :quality_id, :qualityId
    alias_method :quality, :qualityId
    alias_method :creature_id, :creatureId
    alias_method :spell_id, :spellId

    predicate_attr_reader_with_alias :isGround, :ground
    predicate_attr_reader_with_alias :isFlying, :flying
    predicate_attr_reader_with_alias :isAquatic, :aquatic
    predicate_attr_reader_with_alias :isJumping, :jumping

    object_attr_reader :Item, :itemId, target_alias: :id, method_alias: :item, include_keys: [:name, {qualityId: :quality}]
    
    def item_id
      @attrs[:itemId]
    end

    end
  end
end
