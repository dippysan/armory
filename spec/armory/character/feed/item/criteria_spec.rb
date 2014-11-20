# coding: utf-8
require 'helper'

describe Armory::Character::Feed::Item::Criteria do

  before do
    @criteria = {        
              type: "BOSSKILL",
              timestamp: 1403593976000,
              achievement: { id: 1 },
              
              quantity: 3,
              name: "Sha of Pride",
              featOfStrength: false,
              criteria: { id: 2 },
            }

    @feed_item = Armory::Character::Feed::Item.create(@criteria)
  end

  it "returns correct class according to type" do
    expect(Armory::Character::Feed::Item.create({type: "ACHIEVEMENT"})).to be_a Armory::Character::Feed::Item::Achievement
    expect(Armory::Character::Feed::Item.create({type: "BOSSKILL"})).to be_a Armory::Character::Feed::Item::BossKill
    expect(Armory::Character::Feed::Item.create({type: "CRITERIA"})).to be_a Armory::Character::Feed::Item::Criteria
    expect(Armory::Character::Feed::Item.create({type: "LOOT"})).to be_a Armory::Character::Feed::Item::Loot
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(@criteria)
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
      expect(@feed_item.achievement).to be_a Armory::Character::Achievements::Completed
      expect(@feed_item.criteria).to be_a Armory::Character::Achievements::Criteria
    end

    it '#achievement returns Armory::Character::Achievements::Completed with id and timestamp inherited from Item' do
      ach = @feed_item.achievement
      expect(ach).to be_a Armory::Character::Achievements::Completed
      expect(ach.id).to be_a Integer
      expect(ach.id).to eq(1)
      expect(ach.timestamp).to be_a Time
      expect(ach.timestamp).to eq(Time.at(1403593976000/1000))
    end

    it '#criteria returns Armory::Character::Achievements::Criteria with id and timestamp inherited from Item' do
      crt = @feed_item.criteria
      expect(crt).to be_a Armory::Character::Achievements::Criteria
      expect(crt.id).to be_a Integer
      expect(crt.id).to eq(2)
      expect(crt.timestamp).to be_a Time
      expect(crt.timestamp).to eq(Time.at(1403593976000/1000))
    end
  end

end
