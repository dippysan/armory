require 'armory/identity.rb'
require 'equalizer'

module Armory
  module Data
    class Pet < Armory::MetaMethods
      include Equalizer.new(:item_id)

      attr_reader :name, :spellId, :creatureId, :itemId, :qualityId, :icon, :battlePetGuid, :creatureName
      alias_method :spell_id, :spellId
      alias_method :creature_id, :creatureId
      alias_method :item_id, :itemId
      alias_method :quality_id, :qualityId
      alias_method :quality, :qualityId
      alias_method :battle_pet_guid, :battlePetGuid
      alias_method :creature_name, :creatureName

      predicate_attr_reader_with_alias :isFavorite, :favorite
      predicate_attr_reader_with_alias :isFirstAbilitySlotSelected, :first_ability_slot_selected
      predicate_attr_reader_with_alias :isSecondAbilitySlotSelected, :second_ability_slot_selected
      predicate_attr_reader_with_alias :isThirdAbilitySlotSelected, :third_ability_slot_selected
      predicate_attr_reader_with_alias :canBattle, :battle
      alias_method :first?, :first_ability_slot_selected?
      alias_method :second?, :second_ability_slot_selected?
      alias_method :third?, :third_ability_slot_selected?

      object_attr_reader :Item, :itemId, target_alias: :id, method_alias: :item,
          include_keys: [IncludeKey.new(:name), IncludeKey.new(:qualityId, :quality)]
      object_attr_reader :'Data::PetStats', :stats
      
    end
  end
end
