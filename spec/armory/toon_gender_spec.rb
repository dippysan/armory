require 'helper'

describe Armory::ToonGender do

  it '#name returns male' do
    tgender = Armory::ToonGender.new(:id => 0)
    expect(tgender.name).to eq('Male')
  end

  it '#name returns female' do
    tgender = Armory::ToonGender.new(:id => 1)
    expect(tgender.name).to eq('Female')
  end

  describe '#==' do
    it 'returns true when object ids are the same' do
      tgender1 = Armory::ToonGender.new({ id: 1 })
      tgender2 = Armory::ToonGender.new({ id: 1 })
      expect(tgender1 == tgender2).to be true
    end
    it 'returns false when objects ids are different' do
      tgender1 = Armory::ToonGender.new({ id: 1 })
      tgender2 = Armory::ToonGender.new({ id: 0 })
      expect(tgender1 == tgender2).to be false
    end
  end


end
