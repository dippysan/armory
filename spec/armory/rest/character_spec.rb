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
      expect(character.achievements).to be_a Armory::Data::Achievements
      expect(character.achievements.first).to be_a Armory::Data::Achievement
      expect(character.achievements.achievement_criteria).to be_a Array
      expect(character.achievements.achievement_criteria.first).to be_a Armory::Data::AchievementCriteria

      expect(character.achievements.achievement_criteria.first.quantity).to eq(1)
      expect(character.achievements.achievement_criteria.first.timestamp).to eq(Time.at(1416313542000/1000))

      expect(character.achievements.achievements_completed).to be_a Array
      expect(character.achievements.achievements_completed.first).to eq(9141)
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
      expect(character.feed.first).to be_a Armory::Data::Feed::Item
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

  describe '#character_pvp' do
    before do
      stub_get('/wow/character/Illidan/Zerosurv', {fields:"pvp"})
        .to_return(:body => fixture('character_pvp.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid pvp data' do
      character = @client.character_pvp('Illidan','Zerosurv')
      expect(character).to be_a Armory::Character

      pvp = character.pvp
      expect(pvp).to be_a Armory::Character::PvP

      expect(pvp.v2).to be_a Armory::Data::ArenaBracket
      expect(pvp.v3).to be_a Armory::Data::ArenaBracket
      expect(pvp.v5).to be_a Armory::Data::ArenaBracket
      expect(pvp.rbg).to be_a Armory::Data::ArenaBracket
      expect(pvp.unknown).to be_a Armory::Data::ArenaBracket

      expect(pvp.v2.season_played).to eq(856)
      expect(pvp.v3.season_lost).to eq(103)
      expect(pvp.v5.weekly_won).to eq(0)
      expect(pvp.rbg.slug).to eq("rbg")
      expect(pvp.unknown.rating).to eq(576)

    end
  end

  describe '#character_talents' do
    before do
      stub_get('/wow/character/Illidan/Zerosurv', {fields:"talents"})
        .to_return(:body => fixture('character_talent.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})

      @character = @client.character_talents('Illidan','Zerosurv')
      @talent = @character.talents
    end
    it 'returns valid talent/glyph/spec data' do
      expect(@character).to be_a Armory::Character
      expect(@talent).to be_a Array
    end

    it "returns data for spec 1" do
      spec = @talent.first

      expect(spec).to be_a Armory::Character::Talents
      expect(spec.selected?).to eq(false)
      expect(spec.calc_talent).to eq("000022.")
      expect(spec.talents.first.tier).to eq(4)
      expect(spec.talents.first.column).to eq(2)
      expect(spec.talents.first.spell.id).to eq(114030)

      expect(spec.spec.name).to eq("Protection")
      expect(spec.spec.order).to eq(2)
      
      expect(spec.glyphs.major.first.id).to eq(502)
      expect(spec.glyphs.major.first.name).to eq("Glyph of Shield Slam")
      expect(spec.glyphs.major.first.item.id).to eq(43425)
      expect(spec.glyphs.major.first.item.name).to eq("Glyph of Shield Slam")
      expect(spec.glyphs.minor.last.id).to eq(765)
    end

    it "returns data for spec 2" do
      spec = @talent.last

      expect(spec).to be_a Armory::Character::Talents
      expect(spec.selected?).to eq(true)
      expect(spec.calc_talent).to eq("110022.")
      expect(spec.talents.last.tier).to eq(0)
      expect(spec.talents.last.column).to eq(1)
      expect(spec.talents.last.spell.id).to eq(103827)

      expect(spec.spec.name).to eq("Fury")
      expect(spec.spec.order).to eq(1)
      
      expect(spec.glyphs.major.last.id).to eq(509)
      expect(spec.glyphs.minor.last.id).to eq(765)
    end


  end

end
