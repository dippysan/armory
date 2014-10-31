require 'helper'

describe Armory::Error do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#code' do
    it 'returns the error code' do
      error = Armory::Error.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      error = Armory::Error.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end

  [nil, 'error', 'errors'].each do |key|
    context "when JSON body contains #{key.inspect}" do
      before do
        body = "{\"#{key}\":\"Internal Server Error\"}" unless body.nil?
        stub_get('/wow/realm/status')
          .with()
          .to_return(:status => 500, :body => body, :headers => {:content_type => 'application/json;charset=UTF-8'})
      end
      it 'raises an exception with the proper message' do
        expect { @client.realm_status(region: 'US', apikey: 'API') }.to raise_error(Armory::Error::InternalServerError)
      end
    end
  end

  Armory::Error.errors.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get('/wow/realm/status')
          .with()
          .to_return(:status => status, :body => '{}', :headers => {:content_type => 'application/json;charset=UTF-8'})
      end
      it "raises #{exception}" do
        expect { @client.realm_status(region: 'US', apikey: 'API') }.to raise_error(exception)
      end
    end
  end
end
