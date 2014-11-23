# coding: utf-8
require 'helper'

describe Armory::Data::PetStats do

  before do
    @data = {
                speciesId: 441,
                breedId: 17,
                petQualityId: 3,
                level: 25,
                health: 1546,
                power: 257,
                speed: 292
            }
    @item = Armory::Data::PetStats.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::PetStats with basic data' do
      expect(@item).to be_a Armory::Data::PetStats

      expect(@item.species_id).to be_a Integer
      expect(@item.species_id).to eq(441)
      expect(@item.breed_id).to be_a Integer
      expect(@item.breed_id).to eq(17)
      expect(@item.pet_quality_id).to be_a Integer
      expect(@item.pet_quality_id).to eq(3)
      expect(@item.quality).to eq(3)
      expect(@item.level).to be_a Integer
      expect(@item.level).to eq(25)
      expect(@item.health).to be_a Integer
      expect(@item.health).to eq(1546)
      expect(@item.power).to be_a Integer
      expect(@item.power).to eq(257)
      expect(@item.speed).to be_a Integer
      expect(@item.speed).to eq(292)

    end
    

  end


end


