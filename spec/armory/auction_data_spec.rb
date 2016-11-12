# coding: utf-8
require 'helper'

describe Armory::AuctionData do

  describe '#new' do
    it 'returns an Armory::AuctionData with the correct data' do
      auction_data = {
          realm: {name: "Kil'jaeden", slug: "kiljaeden"},
          auctions: { auctions:
            [{ auc: 1, item: 2, owner: 'three' }]
          }
        }
      auction = Armory::AuctionData.new('US', auction_data)
      expect(auction).to be_a Armory::AuctionData
      expect(auction.realm).to be_a Armory::Realm
      expect(auction.realm.name).to eq("Kil'jaeden")
      expect(auction.realm.slug).to eq("kiljaeden")
    end
  end



end
