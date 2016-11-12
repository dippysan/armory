# coding: utf-8
require 'helper'

describe Armory::AuctionRealm do

  describe '#realm' do
    it 'returns an Armory::AuctionRealm with the correct data' do
      realm_data = {
        name: "LaughingSkull",
        }
      realm = Armory::AuctionRealm.new('US', realm_data)
      expect(realm).to be_a Armory::AuctionRealm
      expect(realm.name).to eq("LaughingSkull")
    end
  end



end
