# coding: utf-8
require 'helper'

describe Armory::Character::Feed::Item::BossKill do

  before do
    @bosskill = {        
              type: "BOSSKILL",
              timestamp: 1403593976000,
              quantity: 3,
              name: "Sha of Pride",
              featOfStrength: false,
              achievement: { id: 1 },
              criteria: { id: 2 }
            }

    @feed_item = Armory::Character::Feed::Item.create(@bosskill)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(@bosskill)
    end
  end

  describe '#create' do
    it 'returns Armory::Character::Feed::Item::BossKill with the correct data' do
      expect(@feed_item).to be_a Armory::Character::Feed::Item::BossKill
      expect(@feed_item.type).to be_a String
      expect(@feed_item.type).to eq("BOSSKILL")
      expect(@feed_item.timestamp).to be_a Time
      expect(@feed_item.timestamp).to eq(Time.at(1403593976000/1000))
      expect(@feed_item.quantity).to be_a Integer
      expect(@feed_item.quantity).to eq(3)
      expect(@feed_item.name).to be_a String
      expect(@feed_item.name).to eq("Sha of Pride")
      expect(@feed_item.feat_of_strength?).to be_a FalseClass
      expect(@feed_item.achievement).to be_a Armory::Data::Achievement
      expect(@feed_item.criteria).to be_a Armory::Character::Achievements::Criteria
    end

    it '#achievement returns Armory::Data::Achievement with id and timestamp inherited from Item' do
      ach = @feed_item.achievement
      expect(ach).to be_a Armory::Data::Achievement
      expect(ach.id).to be_a Integer
      expect(ach.id).to eq(1)
      expect(ach.timestamp).to be_a Time
      expect(ach.timestamp).to eq(Time.at(1403593976000/1000))
    end

    it '#criteria returns Armory::Character::Achievements::Criteria with id and timestamp inherited from Item' do
      ach = @feed_item.criteria
      expect(ach).to be_a Armory::Character::Achievements::Criteria
      expect(ach.id).to be_a Integer
      expect(ach.id).to eq(2)
      expect(ach.timestamp).to be_a Time
      expect(ach.timestamp).to eq(Time.at(1403593976000/1000))
    end
  end

end
