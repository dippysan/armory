require 'helper'

describe Armory::Data::Gender do

  it '#name returns male' do
    tgender = Armory::Data::Gender.new(:id => 0)
    expect(tgender.name).to eq('Male')
  end

  it '#name returns female' do
    tgender = Armory::Data::Gender.new(:id => 1)
    expect(tgender.name).to eq('Female')
  end

  describe '#==' do
    it 'returns true when object ids are the same' do
      tgender1 = Armory::Data::Gender.new({ id: 1 })
      tgender2 = Armory::Data::Gender.new({ id: 1 })
      expect(tgender1 == tgender2).to be true
    end
    it 'returns false when objects ids are different' do
      tgender1 = Armory::Data::Gender.new({ id: 1 })
      tgender2 = Armory::Data::Gender.new({ id: 0 })
      expect(tgender1 == tgender2).to be false
    end
  end


end
