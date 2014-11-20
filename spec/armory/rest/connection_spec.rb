require 'helper'
require 'armory/error'

describe Armory::REST::Connection do

  before do
    @client = Armory::REST::Connection.new()
  end

  describe '.new' do
    it 'does not raise an exception' do
      expect { Armory::REST::Connection.new }.not_to raise_error
    end
  end

  describe '#connection_options' do
    it 'returns the connection options hash with proxy and user_agent' do
      client = Armory::REST::Connection.new do |config|
        config.proxy               = 'http://localhost:99'
        config.user_agent          = 'My Armory Ruby Gem'
      end

      expect(client.connection_options[:proxy]).to eql('http://localhost:99')
      expect(client.connection_options[:headers][:user_agent]).to eql('My Armory Ruby Gem')
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
    before do
      @test_client = double("client")
      allow(@test_client).to receive(:env).and_return("ENV RETURN")

      @test_connection = double("connection")
      allow(@test_connection).to receive(:send).with(:get, '/path', {param:1}).and_return(@test_client)

      allow(@client).to receive(:connection).and_return(@test_connection)
    end

    it "passes params unchanged" do
      expect(@client.send(:request, :get, '/path', {param:1}, {header:2}))
          .to eq("ENV RETURN")
    end

    it "passes headers to yielded parameter" do
      request_double = double("request")

      yield_passed = nil
      allow(request_double).to receive_message_chain(:headers, :update) {|x| yield_passed = x }

      allow(@test_connection).to receive(:send).and_yield(request_double).and_return(@test_client)

      @client.send(:request, :get, '/path', {param:1}, {header:2})
      expect(yield_passed).to eq({header:2})
    end

  end

  describe '#request errors' do
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
