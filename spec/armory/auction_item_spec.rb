# coding: utf-8
require 'helper'

describe Armory::AuctionItem do

  describe '#AuctionItems' do
    it 'returns an Armory::AuctionItem with the correct data' do
      AuctionItem_data = {
           auc: 594341719,
           item: 76507,
           owner: "Miseur",
           ownerRealm: "Exodar",
           bid: 238042,
           buyout: 250571,
           quantity: 1,
           timeLeft: "SHORT",
           rand: 0,
           seed: 0,
           context: 0,
        }
      AuctionItem = Armory::AuctionItem.new('US',AuctionItem_data)
      expect(AuctionItem).to be_a Armory::AuctionItem
      expect(AuctionItem.id).to eq(594341719)
      expect(AuctionItem.item).to eq(76507)
      expect(AuctionItem.owner).to eq("Miseur")
      expect(AuctionItem.realm).to be_a Armory::AuctionRealm
      expect(AuctionItem.realm.name).to eq("Exodar")
      expect(AuctionItem.bid).to eq(238042)
      expect(AuctionItem.buyout).to eq(250571)
      expect(AuctionItem.quantity).to eq(1)
      expect(AuctionItem.timeleft).to eq("SHORT")
      expect(AuctionItem.rand).to eq(0)
      expect(AuctionItem.seed).to eq(0)
      expect(AuctionItem.context).to eq(0)
    end
  end

  describe '#==' do
    it 'returns true when auction id equal' do
      item1 = Armory::AuctionItem.new("US", auc: 1)
      item2 = Armory::AuctionItem.new("US", auc: 1)
      expect(item1 == item2).to be true
    end
    it 'returns false when auction id are different' do
      item1 = Armory::AuctionItem.new("US", auc: 1)
      item2 = Armory::AuctionItem.new("US", auc: 2)
      expect(item1 == item2).to be false
    end
    it 'returns false when regions are different' do
      item1 = Armory::AuctionItem.new("US", auc: 1)
      item2 = Armory::AuctionItem.new("TW", auc: 1)
      expect(item1 == item2).to be false
    end
  end

end
