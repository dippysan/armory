# coding: utf-8
require 'helper'

describe Armory::Data::Pet do

  before do
    @data = {
            name: "Alpine Hare",
            spellId: 0,
            creatureId: 61690,
            itemId: 1,
            qualityId: 3,
            icon: "inv_misc_rabbit",
            battlePetGuid: "0000000003D5EA33",
            isFavorite: false,
            isFirstAbilitySlotSelected: false,
            isSecondAbilitySlotSelected: true,
            isThirdAbilitySlotSelected: false,
            creatureName: "Alpine Hare",
            canBattle: true,
            stats: {
                speciesId: 441,
                breedId: 17,
                petQualityId: 3,
                level: 25,
                health: 1546,
                power: 257,
                speed: 292
            }
          }
    @item = Armory::Data::Pet.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Pet with basic data' do
      expect(@item).to be_a Armory::Data::Pet

      expect(@item.name).to be_a String
      expect(@item.name).to eq("Alpine Hare")
      expect(@item.spell_id).to be_a Integer
      expect(@item.spell_id).to eq(0)
      expect(@item.creature_id).to be_a Integer
      expect(@item.creature_id).to eq(61690)
      expect(@item.item_id).to be_a Integer
      expect(@item.item_id).to eq(1)
      expect(@item.quality_id).to be_a Integer
      expect(@item.quality_id).to eq(3)
      expect(@item.quality).to be_a Integer
      expect(@item.quality).to eq(3)
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("inv_misc_rabbit")
      expect(@item.battle_pet_guid).to be_a String
      expect(@item.battle_pet_guid).to eq("0000000003D5EA33")
      expect(@item.favorite?).to be_a FalseClass
      expect(@item.favorite?).to eq(false)
      expect(@item.first_ability_slot_selected?).to be_a FalseClass
      expect(@item.first_ability_slot_selected?).to eq(false)
      expect(@item.second_ability_slot_selected?).to be_a TrueClass
      expect(@item.second_ability_slot_selected?).to eq(true)
      expect(@item.third_ability_slot_selected?).to be_a FalseClass
      expect(@item.third_ability_slot_selected?).to eq(false)
      expect(@item.first?).to be_a FalseClass
      expect(@item.first?).to eq(false)
      expect(@item.second?).to be_a TrueClass
      expect(@item.second?).to eq(true)
      expect(@item.third?).to be_a FalseClass
      expect(@item.third?).to eq(false)
      expect(@item.creature_name).to be_a String
      expect(@item.creature_name).to eq("Alpine Hare")
      expect(@item.battle?).to be_a TrueClass
      expect(@item.battle?).to eq(true)
    end

    it 'returns Armory::Item' do
      expect(@item.item).to be_a Armory::Item
      expect(@item.item.id).to eq(1)
    end

    it 'returns Armory::Data::PetStats' do
      expect(@item.stats).to be_a Armory::Data::PetStats
      expect(@item.stats.species_id).to be_a Integer
      expect(@item.stats.species_id).to eq(441)
      expect(@item.stats.breed_id).to be_a Integer
      expect(@item.stats.breed_id).to eq(17)
      expect(@item.stats.pet_quality_id).to be_a Integer
      expect(@item.stats.pet_quality_id).to eq(3)
      expect(@item.stats.quality).to eq(3)
      expect(@item.stats.level).to be_a Integer
      expect(@item.stats.level).to eq(25)
      expect(@item.stats.health).to be_a Integer
      expect(@item.stats.health).to eq(1546)
      expect(@item.stats.power).to be_a Integer
      expect(@item.stats.power).to eq(257)
      expect(@item.stats.speed).to be_a Integer
      expect(@item.stats.speed).to eq(292)

    end
    

  end


end


