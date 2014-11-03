require 'helper'

describe Armory::REST::AuctionData do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#auctiondata' do
    before do
      @url = 'http://us.battle.net/auction-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctions.json?apikey=API'
      stub_request(:get, @url)
        .to_return(:body => fixture('auctiondata.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

    end
    it 'requests the passed url' do
      @client.auctiondata(@url)
      expect(a_request(:get,@url)).to have_been_made
    end
    it 'requests correct URL when passed Addressable::URI' do
      @client.auctiondata(Addressable::URI.parse(@url))
      expect(a_request(:get,@url)).to have_been_made
    end
    it 'returns valid data' do
      auctiondata = @client.auctiondata(@url)
      expect(auctiondata).to be_a Armory::AuctionData
      expect(auctiondata.auctions).to be_an Array
      expect(auctiondata.auctions.first).to be_a Armory::AuctionItem
      expect(auctiondata.auctions.first.ownerrealm).to be_a Armory::AuctionRealm
      expect(auctiondata.auctions.first.ownerrealm.name).to eq("Medivh")
    end
  end

end
