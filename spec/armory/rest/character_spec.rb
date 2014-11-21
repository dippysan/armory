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
      expect(character.achievements.first).to be_a Armory::Character::Achievements::Completed
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


end
