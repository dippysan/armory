require 'helper'

describe Armory::REST::AuctionData do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#auctiondata' do
    before do
      @URL = 'http://us.battle.net/auction-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctions.json'
      stub_get(@URL)
        .to_return(:body => fixture('auctiondata.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

    end
    it 'requests the passed url' do
      @client.auctiondata(@URL)
      expect(a_get(@URL)).to have_been_made
    end
    it 'requests correct URL when passed Addressable::URI' do
      @client.auction(Addressable::URI.parse(@URL))
      expect(a_get(@URL)).to have_been_made
    end
    it 'returns valid data' do
      auctiondata = @client.auctiondata(@URL)
      expect(auctiondata).to be_a Armory::auctiondataFile
      expect(auctiondata.realm).to be_a Armory::BasicRealm
      expect(auctiondata.url.to_s).to eq("http://us.battle.net/auctiondata-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctiondatas.json")
      expect(auctiondata.auctions).to be_an Array
      expect(auctiondata.auctions.first).to be_a Armory::AuctionItem
      expect(auctiondata.auctions.first.ownerrealm).to eq("Medivh")
    end
  end

end
