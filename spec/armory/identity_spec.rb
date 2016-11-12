require 'helper'

describe Armory::Identity do
  describe '#==' do
    it 'returns true for empty objects' do
      item1 = Armory::Identity.new()
      item2 = Armory::Identity.new()
      expect(item1 == item2).to be true
    end
    it 'returns true when object ids are the same' do
      item1 = Armory::Identity.new({ id: 8 })
      item2 = Armory::Identity.new({ id: 8 })
      expect(item1 == item2).to be true
    end
    it 'returns false when objects ids are different' do
      item1 = Armory::Identity.new({ id: 8 })
      item2 = Armory::Identity.new({ id: 10 })
      expect(item1 == item2).to be false
    end
  end

end
