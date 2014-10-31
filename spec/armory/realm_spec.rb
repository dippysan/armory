# coding: utf-8
require 'helper'

describe Armory::Realm do

before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe '#realms' do
    it 'returns an Armory::Realm with the correct data' do
      realm_data ={
          :name => 'Ravencrest',
          :slug => 'ravencrest',
        }
      realm = Armory::Realm.new('US', realm_data)
      expect(realm).to be_a Armory::Realm
      expect(realm.name).to eq("Ravencrest")
      expect(realm.slug).to eq("ravencrest")
    end
  end


  describe '#tolbarad' do
    it 'returns a WorldZone when tolbarad is set' do
      worldzone = Armory::Realm.new("US", :'tol-barad' => {area: 21, status: 0})
      expect(worldzone.tolbarad).to be_a Armory::WorldZone
      expect(worldzone.tolbarad.area).to eq(21)
    end
    it 'returns nil when tolbarad is not set' do
      worldzone = Armory::Realm.new("US")
      expect(worldzone.tolbarad).to be_nil
    end
  end

  describe '#wintergrasp' do
    it 'returns a WorldZone when wintergrasp is set' do
      worldzone = Armory::Realm.new("US", :wintergrasp => {area: 20, status: 1})
      expect(worldzone.wintergrasp).to be_a Armory::WorldZone
      expect(worldzone.wintergrasp.area).to eq(20)
    end
    it 'returns nil when wintergrasp is not set' do
      worldzone = Armory::Realm.new("US")
      expect(worldzone.wintergrasp).to be_nil
    end
  end

  describe '#connected_realms' do
    it 'returns connected_realms' do
      connected_realms = Armory::Realm.new("US", connected_realms: ["realm1", "realm2", "realm3"]).connected_realms
      expect(connected_realms).to be_an Array
      expect(connected_realms.first).to be_a Armory::BasicRealm
      expect(connected_realms.first.slug).to eq("realm1")
    end
    it 'is empty when not set' do
      connected_realms = Armory::Realm.new("US").connected_realms
      expect(connected_realms).to be_empty
    end
  end



end
