# coding: utf-8
require 'helper'

describe Armory::Character::Feed do

  before do
    @feed_data = [{ type: "CRITERIA", points: 5, achievement: { id: 9407 } },
                  { type: "ACHIEVEMENT", feat_of_strength: false, timestamp: 1416301800000 },
                  { type: "LOOT", timestamp: 1416292710000, itemId: 113157 },
                  { type: "BOSSKILL", timestamp: 1403593976000 },
                 ]
    @feed = Armory::Character::Feed.new(@feed_data)
  end

  describe '#feed' do
    it '.feed returns array of Armory::Character::Feed::Item' do
      expect(@feed).to be_a Armory::Character::Feed
      expect(@feed.first).to be_a Armory::Character::Feed::Item::Criteria
      expect(@feed.first.type).to eq("CRITERIA")
      expect(@feed.last).to be_a Armory::Character::Feed::Item::BossKill
      expect(@feed.last.type).to eq("BOSSKILL")
      expect(@feed.count).to eq(4)
    end
  end



end
