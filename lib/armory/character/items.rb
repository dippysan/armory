require 'equalizer'
require 'armory/meta_methods'
require 'armory/enumerable'
require 'memoizable'

SLOT_NAMES = %w(head neck shoulder shirt chest waist legs feet wrist hands
                finger1 finger2 trinket1 trinket2 back mainHand offHand ranged tabard ).map &:to_sym
SLOT_ALIAS = {mainHand: :main_hand, offHand: :off_hand}

module Armory
  class Character::Items < Armory::MetaMethods
    include Memoizable
    include Enumerable

    attr_reader :averageItemLevel, :averageItemLevelEquipped
    alias_method :average_item_level, :averageItemLevel
    alias_method :average_item_level_equipped, :averageItemLevelEquipped

    SLOT_NAMES.each do |slot|
      object_attr_reader :Item, slot, method_alias: SLOT_ALIAS.fetch(slot, slot)
    end

    def slots
      @collection
    end
    memoize :slots


    def initialize(attrs = {})
      super

      @collection = []
      SLOT_NAMES.each_with_index do |slot, slot_id|
        # Insert slot_id into item
        if @attrs.include? slot
          @attrs[slot][:slot] = slot_id
          @collection[slot_id] = self.send(SLOT_ALIAS.fetch(slot, slot))
        end
      end
      
    end


  end
end




