# coding: utf-8
require 'helper'

describe Armory::Character::Pets do

  before do
    @data = {
        numCollected: 1,
        numNotCollected: 450,
        collected: [{
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
        }]
        }
    @item = Armory::Character::Pets.new(@data)
    @first_pet = @item.collected.first
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::Pets with basic data' do
      expect(@item).to be_a Armory::Character::Pets

      expect(@item.num_collected).to be_a Integer
      expect(@item.num_collected).to eq(1)
      expect(@item.num_not_collected).to be_a Integer
      expect(@item.num_not_collected).to eq(450)
    end

    it 'returns list of Armory::Data::Pet with correct data' do

      expect(@item.collected).to be_a Array
      expect(@first_pet.name).to be_a String
      expect(@first_pet.name).to eq("Alpine Hare")
      expect(@first_pet.spell_id).to be_a Integer
      expect(@first_pet.spell_id).to eq(0)
      expect(@first_pet.creature_id).to be_a Integer
      expect(@first_pet.creature_id).to eq(61690)
      expect(@first_pet.item_id).to be_a Integer
      expect(@first_pet.item_id).to eq(1)
      expect(@first_pet.quality_id).to be_a Integer
      expect(@first_pet.quality_id).to eq(3)
      expect(@first_pet.quality).to be_a Integer
      expect(@first_pet.quality).to eq(3)
      expect(@first_pet.icon).to be_a String
      expect(@first_pet.icon).to eq("inv_misc_rabbit")
      expect(@first_pet.battle_pet_guid).to be_a String
      expect(@first_pet.battle_pet_guid).to eq("0000000003D5EA33")
      expect(@first_pet.favorite?).to be_a FalseClass
      expect(@first_pet.favorite?).to eq(false)
      expect(@first_pet.first_ability_slot_selected?).to be_a FalseClass
      expect(@first_pet.first_ability_slot_selected?).to eq(false)
      expect(@first_pet.second_ability_slot_selected?).to be_a TrueClass
      expect(@first_pet.second_ability_slot_selected?).to eq(true)
      expect(@first_pet.third_ability_slot_selected?).to be_a FalseClass
      expect(@first_pet.third_ability_slot_selected?).to eq(false)
      expect(@first_pet.first?).to be_a FalseClass
      expect(@first_pet.first?).to eq(false)
      expect(@first_pet.second?).to be_a TrueClass
      expect(@first_pet.second?).to eq(true)
      expect(@first_pet.third?).to be_a FalseClass
      expect(@first_pet.third?).to eq(false)
      expect(@first_pet.creature_name).to be_a String
      expect(@first_pet.creature_name).to eq("Alpine Hare")
      expect(@first_pet.battle?).to be_a TrueClass
      expect(@first_pet.battle?).to eq(true)
    end

    it 'returns Armory::Item' do
      expect(@first_pet.item).to be_a Armory::Item
      expect(@first_pet.item.id).to eq(1)
    end

    it 'returns Armory::Data::PetStats' do
      expect(@first_pet.stats).to be_a Armory::Data::PetStats
      expect(@first_pet.stats.species_id).to be_a Integer
      expect(@first_pet.stats.species_id).to eq(441)
      expect(@first_pet.stats.breed_id).to be_a Integer
      expect(@first_pet.stats.breed_id).to eq(17)
      expect(@first_pet.stats.pet_quality_id).to be_a Integer
      expect(@first_pet.stats.pet_quality_id).to eq(3)
      expect(@first_pet.stats.quality).to eq(3)
      expect(@first_pet.stats.level).to be_a Integer
      expect(@first_pet.stats.level).to eq(25)
      expect(@first_pet.stats.health).to be_a Integer
      expect(@first_pet.stats.health).to eq(1546)
      expect(@first_pet.stats.power).to be_a Integer
      expect(@first_pet.stats.power).to eq(257)
      expect(@first_pet.stats.speed).to be_a Integer
      expect(@first_pet.stats.speed).to eq(292)

    end
    
    it 'number pets equals array total' do
      expect(@item.collected.count).to eq(@item.num_collected)
    end
    
    it 'enumerates pets' do
      @item.each.with_index do |pet, i|
        expect(pet).to   eq(@item.collected[i])
      end
    end

  end


end


