# coding: utf-8
require 'helper'

describe Armory::Realm do

before do
    @old_stderr = $stderr
    $stderr = StringIO.new

    @worldzoneexample = {
            area: 1,
            :'controlling-faction' => 1,
            status: 0,
            next: 1414741269688
        }
  end

  after do
    $stderr = @old_stderr
  end

  describe '#realms' do
    it 'returns an Armory::Realm with the correct data' do
      realm_data = {
        type: "pvp",
        population: "medium",
        queue: false,
        status: true,
        name: "Aegwynn",
        slug: "aegwynn",
        battlegroup: "Vengeance",
        locale: "en_US",
        timezone: "America/Los_Angeles",
        }
      realm = Armory::Realm.new('US', realm_data)
      expect(realm).to be_a Armory::Realm
      expect(realm.name).to eq("Aegwynn")
      expect(realm.slug).to eq("aegwynn")
      expect(realm.type).to eq("pvp")
      expect(realm.population).to eq("medium")
      expect(realm.battlegroup).to eq("Vengeance")
      expect(realm.locale).to eq("en_US")
      expect(realm.timezone).to eq("America/Los_Angeles")

      expect(realm.queue?).to eq(false)
      expect(realm.status?).to eq(true)
    end
  end


  describe '#tolbarad' do
    it 'returns a WorldZone when tolbarad is set' do
      worldzone = Armory::Realm.new("US", :'tol-barad' => @worldzoneexample)
      expect(worldzone.tolbarad).to be_a Armory::WorldZone
      expect(worldzone.tolbarad.area).to eq(1)
      expect(worldzone.tolbarad.controllingfaction).to eq(1)
      expect(worldzone.tolbarad.status).to eq(0)
      expect(worldzone.tolbarad.next).to eq(1414741269688)
    end
    it 'returns nil when tolbarad is not set' do
      worldzone = Armory::Realm.new("US")
      expect(worldzone.tolbarad).to be_nil
    end
  end

  describe '#wintergrasp' do
    it 'returns a WorldZone when wintergrasp is set' do
      worldzone = Armory::Realm.new("US", wintergrasp: @worldzoneexample)
      expect(worldzone.wintergrasp).to be_a Armory::WorldZone
      expect(worldzone.wintergrasp.area).to eq(1)
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
