require 'helper'

describe Armory::REST::RealmStatus do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#realm_status' do
    before do
      stub_get('/wow/realm/status')
        .to_return(:body => fixture('realm_status.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource' do
      @client.realm_status
      expect(a_get('/wow/realm/status')).to have_been_made
    end
    it 'returns statuses for all realms in this region' do
      realms = @client.realm_status
      expect(realms).to be_a Array
      expect(realms.first).to be_a Armory::Realm
      expect(realms.first.slug).to eq('aegwynn')
    end
  end


end
