# coding: utf-8
require 'helper'

describe Armory::Character::Feed::Item::Loot do

  before do
    @loot = {
        type: "LOOT",
        timestamp: 1416292710000,
        itemId: 113157,
    }

    @feed_item = Armory::Character::Feed::Item.create(@loot)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(@loot)
    end
  end

  describe '#create' do
    it 'returns Armory::Character::Feed::Item::Loot with the correct data' do
      expect(@feed_item).to be_a Armory::Character::Feed::Item::Loot
      expect(@feed_item.type).to be_a String
      expect(@feed_item.type).to eq("LOOT")
      expect(@feed_item.timestamp).to be_a Time
      expect(@feed_item.timestamp).to eq(Time.at(1416292710000/1000))
      expect(@feed_item.item_id).to be_a Integer
      expect(@feed_item.item_id).to eq(113157)
    end

  end

end
