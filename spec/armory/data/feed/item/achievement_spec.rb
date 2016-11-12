# coding: utf-8
require 'helper'

describe Armory::Data::Feed::Item::Achievement do

  before do
    @bosskill = {
        type: "ACHIEVEMENT",
        timestamp: 1416294000000,
        achievement: { id: 9107 },
        featOfStrength: true,
        character: "Coheed",  # Used in Guild::News
    }

    @feed_item = Armory::Data::Feed::Item.create(@bosskill)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@feed_item.attrs).to eq(@bosskill)
    end
  end

  describe '#create' do
    it 'returns Armory::Data::Feed::Item::Achievement with the correct data' do
      expect(@feed_item).to be_a Armory::Data::Feed::Item::Achievement
      expect(@feed_item.type).to be_a String
      expect(@feed_item.type).to eq("ACHIEVEMENT")
      expect(@feed_item.timestamp).to be_a Time
      expect(@feed_item.timestamp).to eq(Time.at(1416294000000/1000))
      expect(@feed_item.feat_of_strength?).to be_a TrueClass
      expect(@feed_item.achievement).to be_a Armory::Data::Achievement
      expect(@feed_item.character).to eq("Coheed")
    end

    it '#achievement returns Armory::Data::Achievement with id and timestamp inherited from Item' do
      ach = @feed_item.achievement
      expect(ach).to be_a Armory::Data::Achievement
      expect(ach.id).to be_a Integer
      expect(ach.id).to eq(9107)
      expect(ach.timestamp).to be_a Time
      expect(ach.timestamp).to eq(Time.at(1416294000000/1000))
    end

  end

end
