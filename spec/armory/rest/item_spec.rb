require 'helper'

describe Armory::REST::Item do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#item' do
    before do
      stub_get('/wow/item/115806')
        .to_return(:body => fixture('item.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
      @item = @client.item(115806)
    end
    it 'returns valid data' do

      expect(@item).to be_a Armory::Item
      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(115806)
      expect(@item.name).to be_a String
      expect(@item.name).to eq("Multistrike Taladite")
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("inv_jewelcrafting_45")
      expect(@item.quality).to be_a Integer
      expect(@item.quality).to eq(2)
    end

  end

end
