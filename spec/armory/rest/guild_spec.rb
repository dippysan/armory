require 'helper'

describe Armory::REST::Guild do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#guild' do
    before do
      stub_get('/wow/guild/Illidan/Blood Legion')
        .to_return(:body => fixture('guild_basic.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource with realm and guild as string' do
      @client.guild('Illidan','Blood Legion')
      expect(a_get('/wow/guild/Illidan/Blood Legion')).to have_been_made
    end
    it 'requests the correct resource with realm as Armory::Realm and guild as string' do
      @client.guild(Armory::Realm.new('US', slug: 'Illidan'),'Blood Legion')
      expect(a_get('/wow/guild/Illidan/Blood Legion')).to have_been_made
    end
    it 'returns valid data' do
      guild = @client.guild('Illidan','Blood Legion')
      expect(guild).to be_a Armory::Guild
      expect(guild.realm).to be_a Armory::BasicRealm
      expect(guild.realm.name).to eq('Illidan')
      expect(guild.name).to be_a String
      expect(guild.name).to eq('Blood Legion')
      expect(guild.level).to be_a Integer
      expect(guild.level).to eq(25)
      expect(guild.side.horde?).to eq(true)
      expect(guild.side.alliance?).to eq(false)
    end
    it 'json returns original data' do
      guild = @client.guild_json('Illidan','Blood Legion')
      expect(guild).to eq(fixture_as_json('guild_basic.json'))
    end
  end

  describe '#guild_achievements' do
    before do
      stub_get('/wow/guild/Illidan/Blood Legion', {fields:"achievements"})
        .to_return(:body => fixture('guild_achievements.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid data' do
      guild = @client.guild_achievements('Illidan','Blood Legion')
      expect(guild).to be_a Armory::Guild
      expect(guild.achievements).to be_a Armory::Data::Achievements
      expect(guild.achievements.first).to be_a Armory::Data::Achievement
      expect(guild.achievements.achievement_criteria).to be_a Array
      expect(guild.achievements.achievement_criteria.first).to be_a Armory::Data::AchievementCriteria

      expect(guild.achievements.achievement_criteria.first.quantity).to eq(42999)
      expect(guild.achievements.achievement_criteria.first.timestamp).to eq(Time.at(1346190241000/1000))

      expect(guild.achievements.achievements_completed).to be_a Array
      expect(guild.achievements.achievements_completed.first).to eq(4860)
    end
  end

  describe '#guild_members' do
    before do
      stub_get('/wow/guild/Illidan/Blood Legion', {fields:"members"})
        .to_return(:body => fixture('guild_members.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'returns valid data' do
      guild = @client.guild_members('Illidan','Blood Legion')
      expect(guild.members).to be_a Array

      first_member = guild.members.first
      expect(first_member).to be_a Armory::Character
      expect(first_member.rank).to eq(7)  # Imported from guild members data
      expect(first_member.name).to eq("Puddy")
      expect(first_member.realm).to be_a Armory::BasicRealm
      expect(first_member.realm.name).to eq("Illidan")
      expect(first_member.battlegroup).to eq("Rampage")
      expect(first_member.level).to eq(63)
      expect(first_member.guild_realm).to eq("Illidan")

      secondlast_member = guild.members[-2]
      expect(secondlast_member).to be_a Armory::Character
      expect(secondlast_member.rank).to eq(7)  # Imported from guild members data
      expect(secondlast_member.name).to eq("Milkspec")
      expect(secondlast_member.spec).to be_a Armory::Data::Spec
      expect(secondlast_member.spec.name).to eq("Feral")
      expect(secondlast_member.class).to be_a Armory::Data::ToonClass
      expect(secondlast_member.class.id).to eq(11)
      expect(secondlast_member.gender.male?).to eq(false)
      
    end
  end

  describe '#guild_news' do
    before do
      stub_get('/wow/guild/Illidan/Encore', {fields:"news"})
        .to_return(:body => fixture('guild_news.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
      @guild = @client.guild_news('Illidan','Encore')
    end
    it 'returns valid data' do
      expect(@guild).to be_a Armory::Guild
      expect(@guild.news).to be_a Array
    end
    it 'returns valid player achievement data' do
      item = @guild.news.first
      expect(item).to be_a Armory::Data::Feed::Item
      expect(item).to be_a Armory::Data::Feed::Item::Achievement
      expect(item.character).to eq("Mephî")
      expect(item.achievement).to be_a Armory::Data::Achievement
      expect(item.achievement.id).to eq(6193)
    end
    it 'returns valid item loot data' do
      item = @guild.news[1]
      expect(item).to be_a Armory::Data::Feed::Item
      expect(item).to be_a Armory::Data::Feed::Item::Loot
      expect(item.character).to eq("Veryhordy")
      expect(item.item_id).to eq(112261)
    end
    it 'returns valid guild achievement data' do
      item = @guild.news[7]
      expect(item).to be_a Armory::Data::Feed::Item
      expect(item).to be_a Armory::Data::Feed::Item::Achievement
      expect(item.character).to eq("Jellosdk")
      expect(item.achievement).to be_a Armory::Data::Achievement
      expect(item.achievement.id).to eq(5056)
    end
    it 'returns valid item purchase data' do
      item = @guild.news[2]
      expect(item).to be_a Armory::Data::Feed::Item
      expect(item).to be_a Armory::Data::Feed::Item::Loot
      expect(item.character).to eq("Gerith")
      expect(item.item_id).to eq(71068)
    end
  end


end
