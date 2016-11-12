require 'helper'

module RequestBare  # For constants

  TEST_REGION = "rg"
  TEST_PATH = "http://#{TEST_REGION}.battle.net/path"
  TEST_METHOD = :testget
  TEST_OPTIONS = { a: 1 }

  describe Armory::RequestBare do

    before do
      @test_client = double("client")
      @request = Armory::RequestBare.new(@test_client, TEST_METHOD, TEST_PATH, TEST_OPTIONS)
    end

    describe '.new' do
      it 'stores passed parameters' do
        expect(@request.client).to eq(@test_client)
        expect(@request.request_method).to eq(TEST_METHOD)
        expect(@request.path).to eq(TEST_PATH)
        expect(@request.options).to eq(TEST_OPTIONS)
      end
    end

    describe '.perform' do
      before do
        allow(@test_client).to receive(:send).with(TEST_METHOD, TEST_PATH, TEST_OPTIONS).and_return(@test_client)
        allow(@test_client).to receive(:body).and_return("returned html")
        @request = Armory::RequestBare.new(@test_client, TEST_METHOD, TEST_PATH, TEST_OPTIONS)
      end

      it 'calls client with method, path and options. Returns body' do
        allow(@test_client).to receive(:status).and_return(200)
        expect(@request.perform).to eq("returned html")
        expect(@request.last_status).to eq(200)
      end

      it 'returns 304 when received' do
        allow(@test_client).to receive(:status).and_return(304)
        @request.perform
        expect(@request.last_status).to eq(304)
      end
    end

    describe '.region' do
      it 'returns region from url' do
        expect(@request.region).to eq(TEST_REGION)
      end
      it 'returns nil when passed invalid url' do
        request = Armory::RequestBare.new(@test_client, TEST_METHOD, "invalid-path", TEST_OPTIONS)
        expect(request.region).to eq(nil)
      end
    end

  end

end
