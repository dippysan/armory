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



end
