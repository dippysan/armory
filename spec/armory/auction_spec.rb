# coding: utf-8
require 'helper'

describe Armory::Auction do

  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe '#auction' do
    before do
      auction_hash = {files: [{
              url: "http://us.battle.net/auction-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctions.json",
              lastModified: 1414758788000
            }]
          }
      @auction = Armory::Auction.new('US', auction_hash)
    end


    it 'returns valid data' do
      expect(@auction).to be_a Armory::Auction
      expect(@auction.url).to be_a Addressable::URI
      expect(@auction.url.to_s).to eq("http://us.battle.net/auction-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctions.json")
      expect(@auction.lastmodified).to be_a Time
      expect(@auction.lastmodified).to eq(Time.at(1414758788000/1000))
    end
  end

end
