require 'helper'

describe Armory::ToonRace do
  describe "with valid constructor" do
    before do
      @toonrace = Armory::ToonRace.new(:id => 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@toonrace.attrs).to eq(:id => 1)
      end
    end

    describe '#new' do
      it 'returns an Armory::ToonRace with the correct data' do
        toonrace = Armory::ToonRace.new({id: 4, mask: 8, side: 'alliance', name: 'Night Elf'})
        expect(toonrace).to be_a Armory::ToonRace
        expect(toonrace.id).to be_a Integer
        expect(toonrace.id).to eq(4)
        expect(toonrace.mask).to be_a Integer
        expect(toonrace.mask).to eq(8)
        expect(toonrace.side).to be_a String
        expect(toonrace.side).to eq('alliance')
        expect(toonrace.name).to be_a String
        expect(toonrace.name).to eq('Night Elf')
      end
    end


  end

end
