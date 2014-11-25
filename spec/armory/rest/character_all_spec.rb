require 'helper'

describe Armory::REST::Character do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#character - all data returned in one query' do
    before do
      stub_get('/wow/character/Illidan/Spazzo', {fields:"achievements,appearance,feed,guild,items,mounts,pets,progression,pvp,talents"})
        .to_return(:body => fixture('character_all.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
      @character = @client.character('Illidan','Spazzo', {fields: "achievements,appearance,feed,guild,items,mounts,pets,progression,pvp,talents"})
    end
    it 'returns valid data' do

      expect(@character).to be_a Armory::Character
      expect(@character.realm).to be_a Armory::BasicRealm
      expect(@character.realm.name).to eq('Illidan')
      expect(@character.name).to be_a String
      expect(@character.name).to eq('Spazzo')

      expect(@character).to be_a Armory::Character
      expect(@character.achievements).to be_a Armory::Data::Achievements
      expect(@character.achievements.first).to be_a Armory::Data::Achievement

      expect(@character.achievements.first.id).to eq(6)
      expect(@character.achievements.first.timestamp).to eq(Time.at(1287871920000/1000))

      expect(@character.achievements.achievement_criteria.first.quantity).to eq(101)
      expect(@character.achievements.achievement_criteria.first.timestamp).to eq(Time.at(1414669166000/1000))
      expect(@character.achievements.achievements_completed).to be_a Array
      expect(@character.achievements.achievements_completed.last).to eq(9727)

    end

    it '#character_appearance' do
      expect(@character.appearance.face_variation).to eq(0)
      expect(@character.appearance.hair_color).to eq(3)
      expect(@character.appearance.cloak?).to eq(false)
    end

    it '#character_feed' do
      expect(@character.feed).to be_a Array
      expect(@character.feed.first).to be_a Armory::Character::Feed::Item::Achievement
      expect(@character.feed.first.achievement.id).to eq(8891)
      expect(@character.feed.first.achievement.icon).to eq("achievement_challengemode_upperbrspire_hourglass")
      
      expect(@character.feed[1]).to be_a Armory::Character::Feed::Item::Criteria
      expect(@character.feed[1].timestamp).to eq(Time.at(1416785437000/1000))
      expect(@character.feed[1].achievement.criteria.first.id).to eq(25623)
      
      expect(@character.feed.last).to be_a Armory::Character::Feed::Item::BossKill
      expect(@character.feed.last.achievement.id).to eq(9269)
      expect(@character.feed.last.feat_of_strength?).to eq(false)
      expect(@character.feed.last.quantity).to eq(3)
    end

    it '#character_guild' do
      expect(@character).to be_a Armory::Character
      expect(@character.guild).to be_a Armory::Guild
      expect(@character.guild.name).to be_a String
      expect(@character.guild.name).to eq("Blood Legion")
    end

    it '#character_items' do
      items = @character.items 

      expect(items).to be_a Armory::Character::Items
      expect(items.average_item_level).to eq(632)

      expect(items.head).to be_a Armory::Item
      expect(items.head.id).to eq(109975)
      expect(items.head.slot).to eq(0)
      expect(items.head.item_level).to eq(630)
      expect(items.head.stats.first.stat).to eq(59)

      expect(items.back).to be_a Armory::Item
      expect(items.back.id).to eq(109906)
      expect(items.back.slot).to eq(14)

      expect(items.off_hand.extras.gem0).to eq(76692)
      expect(items.off_hand.weapon.damage.max).to eq(496)

      expect(items.slots[6].stats[1].amount).to eq(167)
      
    end

    it '#character_mounts' do
      mounts = @character.mounts
      expect(mounts).to be_a Armory::Character::Mounts

      expect(mounts.num_collected).to be_a Integer
      expect(mounts.num_collected).to eq(121)

      expect(mounts.collected.count).to eq(mounts.num_collected)

      first = mounts.first
      expect(first).to be_a Armory::Data::Mount
      expect(first.name).to eq("Albino Drake")
      expect(first.item.name).to eq("Albino Drake")
      expect(first.jumping?).to eq(false)

      last = mounts.collected.last
      expect(last.name).to eq("Tawny Wind Rider")
      expect(last.quality).to eq(3)
      expect(last.item.quality).to eq(3)
      expect(last.creature_id).to eq(18363)
      expect(last.aquatic?).to eq(true)

    end

    it '#character_pets' do
      pets = @character.pets
      expect(pets).to be_a Armory::Character::Pets

      expect(pets.num_collected).to be_a Integer
      expect(pets.num_collected).to eq(69)

      expect(pets.collected.count).to eq(pets.num_collected)

      first = pets.first
      expect(first).to be_a Armory::Data::Pet
      expect(first.name).to eq("Phawkes")
      expect(first.item.name).to eq("Phawkes")
      expect(first.favorite?).to eq(true)

      last = pets.collected.last
      expect(last.name).to eq("Yu'lon Kite")
      expect(last.quality).to eq(1)
      expect(last.stats.breed_id).to eq(3)
      expect(last.stats.power).to eq(0)
      expect(last.third?).to eq(false)

    end

    it '#character_progression' do
      progression = @character.progression
      expect(progression).to be_a Array

      first = progression.first
      expect(first).to be_a Armory::Data::Raid
      expect(first.name).to eq("Molten Core")
      expect(first.bosses.first.name).to eq("Ragnaros")

      middle = progression[30]
      expect(middle.name).to eq("Throne of Thunder")
      expect(middle.bosses.first.name).to eq("Jin'rokh the Breaker")
      expect(middle.bosses.first.heroic_timestamp).to eq(Time.at(1408670511000/1000))

      last = progression.last
      expect(last.name).to eq("Blackrock Foundry")
      expect(last.lfr).to eq(0)
      expect(last.bosses.last.name).to eq("Blackhand")
      expect(last.bosses.last.heroic_kills).to eq(0)
      expect(last.bosses.last.mythic_timestamp).to eq(nil)

    end

    it '#character_pvp' do
      pvp = @character.pvp
      expect(pvp).to be_a Armory::Character::PvP

      expect(pvp.v2).to be_a Armory::Data::ArenaBracket
      expect(pvp.v3).to be_a Armory::Data::ArenaBracket
      expect(pvp.v5).to be_a Armory::Data::ArenaBracket
      expect(pvp.rbg).to be_a Armory::Data::ArenaBracket
      expect(pvp.unknown).to be_a Armory::Data::ArenaBracket

      expect(pvp.v2.season_played).to eq(5)
      expect(pvp.v3.season_lost).to eq(5)
      expect(pvp.v5.weekly_won).to eq(8)
      expect(pvp.rbg.slug).to eq("rbg")
      expect(pvp.unknown.rating).to eq(2)

    end

    describe '#character_talents' do
      before do
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
        expect(spec.calc_talent).to eq("2201021")
        expect(spec.talents.first.tier).to eq(3)
        expect(spec.talents.first.column).to eq(1)
        expect(spec.talents.first.spell.id).to eq(36554)

        expect(spec.spec.name).to eq("Subtlety")
        expect(spec.spec.order).to eq(2)
        
        expect(spec.glyphs.major.first.id).to eq(411)
        expect(spec.glyphs.major.first.name).to eq("Glyph of Sprint")
        expect(spec.glyphs.major.first.item.id).to eq(42974)
        expect(spec.glyphs.major.first.item.name).to eq("Glyph of Sprint")
        expect(spec.glyphs.minor.last.id).to eq(469)
      end

      it "returns data for spec 2" do
        spec = @talent.last

        expect(spec).to be_a Armory::Character::Talents
        expect(spec.selected?).to eq(true)
        expect(spec.calc_talent).to eq("2201020")
        expect(spec.talents.last.tier).to eq(2)
        expect(spec.talents.last.column).to eq(0)
        expect(spec.talents.last.spell.id).to eq(31230)

        expect(spec.spec.name).to eq("Assassination")
        expect(spec.spec.order).to eq(0)
        
        expect(spec.glyphs.major.last.id).to eq(1159)
        expect(spec.glyphs.minor.last.id).to eq(469)
      end

    end

  end

end
