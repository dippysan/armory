# coding: utf-8
require 'helper'

describe Armory::BasicRealm do

  describe '#==' do
    it 'returns true for empty objects' do
      realm1 = Armory::BasicRealm.new("US")
      realm2 = Armory::BasicRealm.new("US")
      expect(realm1 == realm2).to be true
    end
    it 'returns true when objects slugs are the same' do
      realm1 = Armory::BasicRealm.new("US", :slug => 'slug-one', :name => 'foo')
      realm2 = Armory::BasicRealm.new("US", :slug => 'slug-one', :name => 'bar')
      expect(realm1 == realm2).to be true
    end
    it 'returns false when objects slugs are different' do
      realm1 = Armory::BasicRealm.new("US", :slug => 'slug-one')
      realm2 = Armory::BasicRealm.new("US", :slug => 'slug-two')
      expect(realm1 == realm2).to be false
    end
    it 'returns false when regions are different' do
      realm1 = Armory::BasicRealm.new("US", :slug => 'slug-one')
      realm2 = Armory::BasicRealm.new("EU", :slug => 'slug-one')
      expect(realm1 == realm2).to be false
    end
    it 'returns false when classes are different' do
      realm1 = Armory::BasicRealm.new("US", :slug => 'slug-one')
      realm2 = Armory::Error.new()
      expect(realm1 == realm2).to be false
    end
  end



end
