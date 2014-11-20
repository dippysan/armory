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


  describe '#request' do
    before do
      @test_client = double("client")
      allow(@test_client).to receive(:env).and_return("ENV RETURN")

      @test_connection = double("connection")
      allow(@test_connection).to receive(:send).with(:get, '/path', {param:1, apikey:"API"}).and_return(@test_client)

      allow(@client).to receive(:connection).and_return(@test_connection)
    end

    it "adds api_key to headers" do
      allow(@test_connection).to receive(:send).with(:get, '/path', {param:1, apikey:"API"}).and_return(@test_client)
      expect(@client.send(:request, :get, '/path', {param:1}, {header:2}))
          .to eq("ENV RETURN")
    end


    describe "moves last_modified parameter to if-last-modified header" do

      before do
        request_double = double("request")

        @yield_passed = nil
        allow(request_double).to receive_message_chain(:headers, :update) {|x| @yield_passed = x }

        allow(@test_connection).to receive(:send).and_yield(request_double).and_return(@test_client)
      end
      
      it "handles Time and retuns as rfc2822" do
        @client.send(:request, :get, '/path', {param:1, last_modified: Time.at(1416305354).utc}, {header:2})
        expect(@yield_passed).to eq({header:2, :'if-last-modified' => Time.at(1416305354).utc.rfc2822})
      end
      it "handles String and retuns unchanged" do
        @client.send(:request, :get, '/path', {param:1, last_modified: "time string"}, {header:2})
        expect(@yield_passed).to eq({header:2, :'if-last-modified' => "time string"})
      end
      it "returns IncorrectLastUpdate when incorrect last modified date passed" do
        expect { @client.send(:request, :get, '/path', {param:1, last_modified: 123.45}, {header:2}) }
          .to raise_error(Armory::Error::IncorrectLastUpdate)
        
      end
    end
  end


end
