require 'helper'

describe Armory::Data::Faction do
  describe "with valid constructor" do
    before do
      @toonfaction = Armory::Data::Faction.new(:id => 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@toonfaction.attrs).to eq(:id => 1)
      end
    end

    describe '#new' do
      it 'returns an correct alliance data' do
        toonfaction = Armory::Data::Faction.new({id: 0})
        expect(toonfaction).to be_a Armory::Data::Faction
        expect(toonfaction.id).to be_a Integer
        expect(toonfaction.id).to eq(Armory::Data::Faction::ALLIANCE)
        expect(toonfaction.name).to be_a String
        expect(toonfaction.name).to eq('Alliance')
        expect(toonfaction.alliance?).to eq(true)
        expect(toonfaction.horde?).to eq(false)
      end
      it 'returns an correct horde data' do
        toonfaction = Armory::Data::Faction.new({id: 1})
        expect(toonfaction).to be_a Armory::Data::Faction
        expect(toonfaction.id).to be_a Integer
        expect(toonfaction.id).to eq(Armory::Data::Faction::HORDE)
        expect(toonfaction.name).to be_a String
        expect(toonfaction.name).to eq('Horde')
        expect(toonfaction.alliance?).to eq(false)
        expect(toonfaction.horde?).to eq(true)
      end
    end


  end

end
