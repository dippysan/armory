require 'helper'

describe Armory::Data::Race do
  describe "with valid constructor" do
    before do
      @toonrace = Armory::Data::Race.new(:id => 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@toonrace.attrs).to eq(:id => 1)
      end
    end

    describe '#new' do
      it 'returns an Armory::Data::Race with the correct data' do
        toonrace = Armory::Data::Race.new({id: 4, mask: 8, side: 'alliance', name: 'Night Elf'})
        expect(toonrace).to be_a Armory::Data::Race
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
