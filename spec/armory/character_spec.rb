# coding: utf-8
require 'helper'

describe Armory::Character do

before do
    @old_stderr = $stderr
    $stderr = StringIO.new

    @characterexample = {
      lastModified: 1416305354000,
      name: "Frodo",
      realm: "MiddleEarth",
      battlegroup: "Rampage",
      class: 11,
      race: 4,
      gender: 0,
      level: 100,
      achievementPoints: 7280,
      thumbnail: "middleearth/94/4209397-avatar.jpg",
      calcClass: "U",
      totalHonorableKills: 849,
      rank: 1  # guild rank added by guild.members
    }
  end

  after do
    $stderr = @old_stderr
  end

  describe '#characters' do
    it 'returns an Armory::Character with the correct data' do
      character_data = @characterexample
      character = Armory::Character.new('US', character_data)
      expect(character).to be_a Armory::Character
      expect(character.name).to be_a String
      expect(character.name).to eq('Frodo')
      expect(character.last_modified).to be_a Time
      expect(character.last_modified).to eq(Time.at(1416305354000/1000))
      expect(character.realm).to be_a Armory::BasicRealm
      expect(character.realm.name).to eq('MiddleEarth')
      expect(character.class).to be_a Armory::Data::ToonClass
      expect(character.class.id).to eq(11)
      expect(character.race).to be_a Armory::Data::Race
      expect(character.race.id).to eq(4)
      expect(character.gender).to be_a Armory::Data::Gender
      expect(character.gender.id).to eq(0)
      expect(character.level).to be_a Integer
      expect(character.level).to eq(100)
      expect(character.achievement_points).to be_a Integer
      expect(character.achievement_points).to eq(7280)
      expect(character.thumbnail).to be_a String
      expect(character.thumbnail).to eq("middleearth/94/4209397-avatar.jpg")
      expect(character.calc_class).to be_a String
      expect(character.calc_class).to eq('U')
      expect(character.total_honorable_kills).to be_a Integer
      expect(character.total_honorable_kills).to eq(849)
      expect(character.rank).to be_a Integer
      expect(character.rank).to eq(1)
    end
  end


end
