require 'helper'
require 'armory/error'

describe Armory::REST::Client do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end


  describe '.new' do
    context 'when invalid credentials are provided' do
      it 'raises a ConfigurationError exception' do
        expect { Armory::REST::Client.new(:api_key => 54321) }.to raise_exception(Armory::Error::ConfigurationError)
      end
    end

    context 'when no credentials are provided' do
      it 'does not raise an exception' do
        expect { Armory::REST::Client.new }.not_to raise_error
      end
    end
  end

  describe '.credentials?' do
    it 'returns true if only api_key is supplied' do
      client = Armory::REST::Client.new(:api_key => 'API')
      expect(client.credentials?).to be true
    end
    it 'returns false if any credentials are missing' do
      client = Armory::REST::Client.new()
      expect(client.credentials?).to be false
    end
  end

  describe '.api_key?' do
    it 'returns true if only api_key is supplied' do
      client = Armory::REST::Client.new(:api_key => 'API')
      expect(client.api_key?).to be true
    end
    it 'returns false if api_key is missing' do
      client = Armory::REST::Client.new()
      expect(client.api_key?).to be false
    end
  end

  describe '#connection_options' do
    it 'returns the connection options hash with proxy and user_agent' do
      client = Armory::REST::Client.new do |config|
        config.api_key             = 'API'
        config.proxy               = 'http://localhost:99'
        config.user_agent          = 'My Armory Ruby Gem'
      end

      expect(client.connection_options[:proxy]).to eql('http://localhost:99')
      expect(client.connection_options[:headers][:user_agent]).to eql('My Armory Ruby Gem')
    end
  end

  describe '#credentials?' do
    it 'returns true if all credentials are present' do
      client = Armory::REST::Client.new(api_key: "API")
      expect(client.credentials?).to be true
    end
    it 'returns false if any credentials are missing' do
      client = Armory::REST::Client.new()
      expect(client.credentials?).to be false
    end
  end

  describe '#connection' do
    it 'looks like Faraday connection' do
      expect(@client.send(:connection)).to respond_to(:run_request)
    end
    it 'memoizes the connection' do
      c1, c2 = @client.send(:connection), @client.send(:connection)
      expect(c1.object_id).to eq(c2.object_id)
    end
  end

  describe '#request' do
    it 'catches and reraises Faraday timeout errors' do
      allow(@client).to receive(:connection).and_raise(Faraday::Error::TimeoutError.new('execution expired'))
      expect { @client.send(:request, :get, '/path') }.to raise_error(Armory::Error::RequestTimeout)
    end
    it 'catches and reraises Timeout errors' do
      allow(@client).to receive(:connection).and_raise(Timeout::Error.new('execution expired'))
      expect { @client.send(:request, :get, '/path') }.to raise_error(Armory::Error::RequestTimeout)
    end
    it 'catches and reraises Faraday client errors' do
      allow(@client).to receive(:connection).and_raise(Faraday::Error::ClientError.new('connection failed'))
      expect { @client.send(:request, :get, '/path') }.to raise_error(Armory::Error)
    end
    it 'catches and reraises JSON::ParserError errors' do
      allow(@client).to receive(:connection).and_raise(JSON::ParserError.new('unexpected token'))
      expect { @client.send(:request, :get, '/path') }.to raise_error(Armory::Error)
    end
  end


end
