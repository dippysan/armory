# coding: utf-8
require 'helper'

describe Armory::Data::Feed::News do

  before do
    @feed_item = Armory::Data::Feed::News.new(type: "playerAchievement", timestamp: 1416566580000)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(type: "playerAchievement", timestamp: 1416566580000)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Feed::News with the correct data' do
      expect(@feed_item).to be_a Armory::Data::Feed::News
      expect(@feed_item.type).to be_a String
      expect(@feed_item.type).to eq("playerAchievement")
      expect(@feed_item.timestamp).to be_a Time
      expect(@feed_item.timestamp).to eq(Time.at(1416566580000/1000))
    end
  end

  describe '#create' do
    it "can create Item::Achievement" do
      item = Armory::Data::Feed::News.create(type: "playerAchievement", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Achievement
    end

    it "can create Item::ItemLoot" do
      item = Armory::Data::Feed::News.create(type: "itemLoot", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Loot
    end

    it "can create Item::ItemLoot for purchase" do
      item = Armory::Data::Feed::News.create(type: "itemPurchase", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Loot
    end

    it "can create Item::Achievement for guild" do
      item = Armory::Data::Feed::News.create(type: "guildAchievement", timestamp: 1403593976000)
      expect(item).to be_a Armory::Data::Feed::Item::Achievement
    end
  end


end
