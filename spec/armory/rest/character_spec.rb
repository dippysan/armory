require 'helper'

describe Armory::REST::Character do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#character' do
    before do
      stub_get('/wow/character/middleearth/frodo')
        .to_return(:body => fixture('character_basic.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource with realm and character as string' do
      @client.character('middleearth','frodo')
      expect(a_get('/wow/character/middleearth/frodo')).to have_been_made
    end
    it 'requests the correct resource with realm as Armory::Realm and character as string' do
      @client.character(Armory::Realm.new('US', slug: 'middleearth'),'frodo')
      expect(a_get('/wow/character/middleearth/frodo')).to have_been_made
    end
    it 'returns valid data' do
      character = @client.character('middleearth','frodo')
      expect(character).to be_a Armory::Character
      expect(character.realm).to be_a Armory::BasicRealm
      expect(character.realm.name).to eq('Middleearth')
      expect(character.name).to eq('Frodo')
      expect(character.name).to be_a String
      expect(character.name).to eq('Frodo')
    end
  end

  describe '#character_achievements' do
    before do
      stub_get('/wow/character/middleearth/frodo', {fields:"achievements"})
        .to_return(:body => fixture('character_achievements.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid data' do
      character = @client.character_achievements('middleearth','frodo')
      expect(character).to be_a Armory::Character
      expect(character.achievements).to be_a Armory::Character::Achievements
      expect(character.achievements.first).to be_a Armory::Data::Achievement
      expect(character.achievements.achievement_criteria).to be_a Array
      expect(character.achievements.achievement_criteria.first).to be_a Armory::Character::Achievements::Criteria
      expect(character.name).to be_a String
      expect(character.name).to eq('Frodo')
    end
  end


  describe '#character_appearance' do
    before do
      stub_get('/wow/character/middleearth/frodo', {fields:"appearance"})
        .to_return(:body => fixture('character_appearance.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid data' do
      character = @client.character_appearance('middleearth','frodo')
      expect(character).to be_a Armory::Character
      expect(character.appearance).to be_a Armory::Character::Appearance
      expect(character.appearance.face_variation).to be_a Integer
      expect(character.appearance.face_variation).to eq(0)
    end
  end

  describe '#character_feed' do
    before do
      stub_get('/wow/character/middleearth/frodo', {fields:"feed"})
        .to_return(:body => fixture('character_feed.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid data' do
      character = @client.character_feed('middleearth','frodo')
      expect(character).to be_a Armory::Character
      expect(character.feed).to be_a Array
      expect(character.feed.first).to be_a Armory::Character::Feed::Item
      expect(character.feed.first.achievement.id).to eq(9407)
    end
  end

  describe '#character_guild' do
    before do
      stub_get('/wow/character/middleearth/frodo', {fields:"guild"})
        .to_return(:body => fixture('character_guild.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid data' do
      character = @client.character_guild('middleearth','frodo')
      expect(character).to be_a Armory::Character
      expect(character.guild).to be_a Armory::Guild
      expect(character.guild.name).to be_a String
      expect(character.guild.name).to eq("The Best Guild")
    end
  end


  describe '#character_items' do
    before do
      stub_get('/wow/character/Illidan/Sleight', {fields:"items"})
        .to_return(:body => fixture('character_items.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid item data' do
      character = @client.character_items('Illidan','Sleight')
      expect(character).to be_a Armory::Character

      items = character.items 
      expect(items).to be_a Armory::Character::Items
      expect(items.average_item_level).to eq(629)
      expect(items.head).to be_a Armory::Item
      expect(items.head.id).to eq(118941)
      expect(items.head.slot).to eq(0)
      expect(items.trinket1).to be_a Armory::Item
      expect(items.trinket1.id).to eq(119927)
      expect(items.trinket1.slot).to eq(12)
      expect(items.main_hand.extras.enchant).to eq(5331)
      expect(items.slots[6].stats[1].amount).to eq(87)
      
    end
  end

  describe '#character_mounts' do
    before do
      stub_get('/wow/character/Illidan/Sleight', {fields:"mounts"})
        .to_return(:body => fixture('character_mounts.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid mount data' do
      character = @client.character_mounts('Illidan','Sleight')
      expect(character).to be_a Armory::Character

      mounts = character.mounts
      expect(mounts).to be_a Armory::Character::Mounts

      expect(mounts.num_collected).to be_a Integer
      expect(mounts.num_collected).to eq(17)

      expect(mounts.collected.count).to eq(mounts.num_collected)

      first = mounts.first
      expect(first).to be_a Armory::Data::Mount
      expect(first.name).to eq("Albino Drake")
      expect(first.item.name).to eq("Albino Drake")
      expect(first.jumping?).to eq(false)

      last = mounts.collected.last
      expect(last.name).to eq("Black War Bear")
      expect(last.quality).to eq(4)
      expect(last.item.quality).to eq(4)
      expect(last.creature_id).to eq(32205)

    end
  end

  describe '#character_pets' do
    before do
      stub_get('/wow/character/Illidan/Sleight', {fields:"pets"})
        .to_return(:body => fixture('character_pets.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid pets data' do
      character = @client.character_pets('Illidan','Sleight')
      expect(character).to be_a Armory::Character

      pets = character.pets
      expect(pets).to be_a Armory::Character::Pets

      expect(pets.num_collected).to be_a Integer
      expect(pets.num_collected).to eq(290)

      expect(pets.collected.count).to eq(pets.num_collected)

      first = pets.first
      expect(first).to be_a Armory::Data::Pet
      expect(first.name).to eq("Alpine Hare")
      expect(first.item.name).to eq("Alpine Hare")
      expect(first.favorite?).to eq(false)

      last = pets.collected.last
      expect(last.name).to eq("Yu'lon Kite")
      expect(last.quality).to eq(1)
      expect(last.item.quality).to eq(1)
      expect(last.third?).to eq(false)

    end
  end

  describe '#character_progression' do
    before do
      stub_get('/wow/character/Illidan/Sleight', {fields:"progression"})
        .to_return(:body => fixture('character_progression.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid progression data' do
      character = @client.character_progression('Illidan','Sleight')
      expect(character).to be_a Armory::Character

      progression = character.progression
      expect(progression).to be_a Array

      first = progression.first
      expect(first).to be_a Armory::Data::Raid
      expect(first.name).to eq("Molten Core")
      expect(first.bosses.first.name).to eq("Ragnaros")

      middle = progression[20]
      expect(middle.name).to eq("The Ruby Sanctum")
      expect(middle.bosses.first.name).to eq("Halion")
      expect(middle.bosses.first.heroic_timestamp).to eq(Time.at(1414543173000/1000))

      last = progression.last
      expect(last.name).to eq("Blackrock Foundry")
      expect(last.lfr).to eq(0)
      expect(last.bosses.last.name).to eq("Blackhand")
      expect(last.bosses.last.heroic_kills).to eq(0)
      expect(last.bosses.last.mythic_timestamp).to eq(nil)

    end
  end


end
