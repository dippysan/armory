require 'helper'
require 'addressable/uri'

module Request  # For constants

  TEST_PATH = "/path"
  TEST_METHOD = :testget
  TEST_OPTIONS = { a: 1 }

  describe Armory::Request do
    before do
      @test_client = double("client")
      allow(@test_client).to receive(:send).with(TEST_METHOD, kind_of(URI), kind_of(Hash)).and_return(@test_client)
      allow(@test_client).to receive(:body).and_return("returned html")
      allow(@test_client).to receive(:status).and_return(200)
      @request = Armory::Request.new(@test_client, TEST_METHOD, TEST_PATH, TEST_OPTIONS)
    end

    describe '.new' do
      it 'stores passed parameters' do
        expect(@request.client).to eql(@test_client)
        expect(@request.request_method).to eql(TEST_METHOD)
        expect(@request.path.to_s).to include(TEST_PATH)
        expect(@request.options).to be_kind_of(Hash)
      end
      it 'translates path to full path including region' do
        expect(@request.path.to_s).to eq("https://#{@request.region}.api.battle.net#{TEST_PATH}")
      end
      it 'adds locale to options' do
        expect(@request.options).to include(locale: "en_US")
      end
    end

    describe '.perform' do
      it 'calls client with method, path and options. Returns body' do
        expect(@request.perform).to eq("returned html")
      end
    end

    describe '.region' do
      it 'defaults to US' do
        expect(@request.region).to eq("US")
      end
      it 'stores and returns upcase version of region' do
        @request.region = "za"
        expect(@request.region).to eq("ZA")
      end
    end

    describe '.locale' do
      it 'defaults to en_US' do
        expect(@request.locale).to eq("en_US")
      end
      it 'stores and returns locale' do
        @request.locale = "locale"
        expect(@request.locale).to eq("locale")
      end
    end

  end
end
