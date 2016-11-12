require 'helper'

describe Armory::REST::Auction do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#auction' do
    before do
      stub_get('/wow/auction/data/realm1')
        .to_return(:body => fixture('auction.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource with realm as string' do
      @client.auction('realm1')
      expect(a_get('/wow/auction/data/realm1')).to have_been_made
    end
    it 'requests the correct resource with realm as Armory::Realm' do
      @client.auction(Armory::Realm.new('US', slug: 'realm1'))
      expect(a_get('/wow/auction/data/realm1')).to have_been_made
    end
    it 'returns valid data' do
      auction = @client.auction('realm1')
      expect(auction).to be_a Armory::Auction
      expect(auction.url).to be_a Addressable::URI
      expect(auction.url.to_s).to eq("http://us.battle.net/auction-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctions.json")
      expect(auction.lastmodified).to be_a Time
      expect(auction.lastmodified).to eq(Time.at(1414758788000/1000))
    end
end

end
