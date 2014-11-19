require 'helper'

describe Armory::BaseResource do
  describe '#==' do
    it 'returns true for empty objects' do
      baseresource1 = Armory::BaseResource.new()
      baseresource2 = Armory::BaseResource.new()
      expect(baseresource1 == baseresource2).to be true
    end
    it 'returns true when object ids are the same' do
      baseresource1 = Armory::BaseResource.new({ id: 8 })
      baseresource2 = Armory::BaseResource.new({ id: 8 })
      expect(baseresource1 == baseresource2).to be true
    end
    it 'returns false when objects ids are different' do
      baseresource1 = Armory::BaseResource.new({ id: 8 })
      baseresource2 = Armory::BaseResource.new({ id: 10 })
      expect(baseresource1 == baseresource2).to be false
    end
  end

end
