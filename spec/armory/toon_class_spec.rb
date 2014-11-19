require 'helper'

describe Armory::ToonClass do
  describe "with valid constructor" do
    before do
      @toonclass = Armory::ToonClass.new(:id => 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@toonclass.attrs).to eq(:id => 1)
      end
    end

    describe '#new' do
      it 'returns an Armory::ToonClass with the correct data' do
        toonclass = Armory::ToonClass.new({id: 8, mask: 128, powerType: 'mana', name: 'Mage'})
        expect(toonclass).to be_a Armory::ToonClass
        expect(toonclass.id).to be_a Integer
        expect(toonclass.id).to eq(8)
        expect(toonclass.mask).to be_a Integer
        expect(toonclass.mask).to eq(128)
        expect(toonclass.power_type).to be_a String
        expect(toonclass.power_type).to eq('mana')
        expect(toonclass.name).to be_a String
        expect(toonclass.name).to eq('Mage')
      end
    end

  end

end
