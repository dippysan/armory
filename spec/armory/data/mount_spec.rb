# coding: utf-8
require 'helper'

describe Armory::Data::Mount do

  before do
    @data = {
            name: "Albino Drake",
            spellId: 60025,
            creatureId: 32158,
            itemId: 44178,
            qualityId: 4,
            icon: "ability_mount_drake_blue",
            isGround: true,
            isFlying: true,
            isAquatic: true,
            isJumping: false
        }
    @item = Armory::Data::Mount.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Mount with basic data' do
      expect(@item).to be_a Armory::Data::Mount

      expect(@item.name).to be_a String
      expect(@item.name).to eq("Albino Drake")
      expect(@item.spell_id).to be_a Integer
      expect(@item.spell_id).to eq(60025)
      expect(@item.creature_id).to be_a Integer
      expect(@item.creature_id).to eq(32158)
      expect(@item.item_id).to be_a Integer
      expect(@item.item_id).to eq(44178)
      expect(@item.quality_id).to be_a Integer
      expect(@item.quality_id).to eq(4)
      expect(@item.quality).to be_a Integer
      expect(@item.quality).to eq(4)
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("ability_mount_drake_blue")
      expect(@item.ground?).to be_a TrueClass
      expect(@item.ground?).to eq(true)
      expect(@item.flying?).to be_a TrueClass
      expect(@item.flying?).to eq(true)
      expect(@item.aquatic?).to be_a TrueClass
      expect(@item.aquatic?).to eq(true)
      expect(@item.jumping?).to be_a FalseClass
      expect(@item.jumping?).to eq(false)

    end
    
    it '#item imports item data from mount' do

      expect(@item.item).to be_a Armory::Item
      expect(@item.item.id).to be_a Integer
      expect(@item.item.id).to eq(44178)
      expect(@item.item.name).to be_a String
      expect(@item.item.name).to eq("Albino Drake")
      expect(@item.item.quality).to be_a Integer
      expect(@item.item.quality).to eq(4)

    end

  end


end


