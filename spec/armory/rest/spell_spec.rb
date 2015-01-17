require 'helper'

describe Armory::REST::Spell do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#spell' do
    before do
      stub_get('/wow/spell/7418')
        .to_return(:body => fixture('spell.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
      @spell = @client.spell(7418)
    end
    it 'returns valid data' do
      expect(@spell).to be_a Armory::Data::Spell
      expect(@spell.id).to be_a Integer
      expect(@spell.id).to eq(7418)
      expect(@spell.name).to be_a String
      expect(@spell.name).to eq("Minor Health")
      expect(@spell.icon).to be_a String
      expect(@spell.icon).to eq("spell_holy_greaterheal")
      expect(@spell.cast_time).to be_a String
      expect(@spell.cast_time).to eq("1.5 sec cast")
    end

  end

end
