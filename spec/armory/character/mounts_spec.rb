# coding: utf-8
require 'helper'

describe Armory::Character::Mounts do

  before do
    @data = {
        numCollected: 1,
        numNotCollected: 133,
        collected: [{
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
            }]
        }
    @item = Armory::Character::Mounts.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::Mounts with basic data' do
      expect(@item).to be_a Armory::Character::Mounts

      expect(@item.num_collected).to be_a Integer
      expect(@item.num_collected).to eq(1)
      expect(@item.num_not_collected).to be_a Integer
      expect(@item.num_not_collected).to eq(133)
    end

    it 'returns list of Armory::Data::Mount with correct data' do

      expect(@item.collected).to be_a Array
      first_mount = @item.collected.first
      expect(first_mount).to be_a Armory::Data::Mount
      expect(first_mount.name).to be_a String
      expect(first_mount.name).to eq("Albino Drake")
      expect(first_mount.spell_id).to be_a Integer
      expect(first_mount.spell_id).to eq(60025)
      expect(first_mount.creature_id).to be_a Integer
      expect(first_mount.creature_id).to eq(32158)
      expect(first_mount.item_id).to be_a Integer
      expect(first_mount.item_id).to eq(44178)
      expect(first_mount.item).to be_a Armory::Item
      expect(first_mount.item.id).to be_a Integer
      expect(first_mount.item.id).to eq(44178)
      expect(first_mount.quality_id).to be_a Integer
      expect(first_mount.quality_id).to eq(4)
      expect(first_mount.quality).to be_a Integer
      expect(first_mount.quality).to eq(4)
      expect(first_mount.icon).to be_a String
      expect(first_mount.icon).to eq("ability_mount_drake_blue")
      expect(first_mount.ground?).to be_a TrueClass
      expect(first_mount.ground?).to eq(true)
      expect(first_mount.flying?).to be_a TrueClass
      expect(first_mount.flying?).to eq(true)
      expect(first_mount.aquatic?).to be_a TrueClass
      expect(first_mount.aquatic?).to eq(true)
      expect(first_mount.jumping?).to be_a FalseClass
      expect(first_mount.jumping?).to eq(false)

    end
    
    it 'number mounts equals array total' do
      expect(@item.collected.count).to eq(@item.num_collected)
    end
    
    it 'enumerates mounts' do
      @item.each.with_index do |mount, i|
        expect(mount).to   eq(@item.collected[i])
      end
    end

  end


end


