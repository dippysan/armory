# coding: utf-8
require 'helper'

describe Armory::Character::Feed::Item do

  before do
    @feed_item = Armory::Character::Feed::Item.new(type: "BOSSKILL", timestamp: 1403593976000)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(type: "BOSSKILL", timestamp: 1403593976000)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::Feed::Item with the correct data' do
      expect(@feed_item).to be_a Armory::Character::Feed::Item
      expect(@feed_item.type).to be_a String
      expect(@feed_item.type).to eq("BOSSKILL")
      expect(@feed_item.timestamp).to be_a Time
      expect(@feed_item.timestamp).to eq(Time.at(1403593976000/1000))
    end
  end

end
