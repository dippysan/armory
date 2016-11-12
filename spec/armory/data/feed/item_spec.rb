# coding: utf-8
require 'helper'

describe Armory::Data::Feed::Item do

  before do
    @feed_item = Armory::Data::Feed::Item.new(type: "BOSSKILL", timestamp: 1403593976000)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(type: "BOSSKILL", timestamp: 1403593976000)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Feed::Item with the correct data' do
      expect(@feed_item).to be_a Armory::Data::Feed::Item
      expect(@feed_item.type).to be_a String
      expect(@feed_item.type).to eq("BOSSKILL")
      expect(@feed_item.timestamp).to be_a Time
      expect(@feed_item.timestamp).to eq(Time.at(1403593976000/1000))
    end
  end

  describe '#create' do
    it "can create Item::BossKill" do
      item = Armory::Data::Feed::Item.create(type: "BOSSKILL", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::BossKill
    end

    it "can create Item::Loot" do
      item = Armory::Data::Feed::Item.create(type: "LOOT", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Loot
    end

    it "can create Item::Criteria" do
      item = Armory::Data::Feed::Item.create(type: "CRITERIA", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Criteria
    end

    it "can create Item::Achievement" do
      item = Armory::Data::Feed::Item.create(type: "ACHIEVEMENT", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Achievement
    end
  end


end
