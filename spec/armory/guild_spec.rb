# coding: utf-8
require 'helper'

describe Armory::Guild do

  describe "from guild" do

    before do
      @data = {
          lastModified: 1416903598000,
          name: "The Best Guild",
          realm: "Ravencrest",
          battlegroup: "Rampage",
          level: 25,
          side: 1,
          achievementPoints: 2210,
          emblem: {
              icon: 138,
              iconColor: "ff00671f",
              border: 3,
              borderColor: "ff00671a",
              backgroundColor: "ff232323"
          },
      }
      @item = Armory::Guild.new('US', @data)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@item.attrs).to eq(@data)
      end
    end

    describe '#new' do
      it 'returns Armory::Guild with the correct data' do
        expect(@item).to be_a Armory::Guild
        expect(@item.modified).to be_a Time
        expect(@item.modified).to eq(Time.at(1416903598000/1000))
        expect(@item.name).to be_a String
        expect(@item.name).to eq("The Best Guild")
        expect(@item.realm).to be_a Armory::BasicRealm
        expect(@item.realm.name).to eq("Ravencrest")
        expect(@item.battlegroup).to be_a String
        expect(@item.battlegroup).to eq("Rampage")
        expect(@item.level).to be_a Integer
        expect(@item.level).to eq(25)
        expect(@item.side).to be_a Armory::Data::Faction
        expect(@item.faction).to be_a Armory::Data::Faction
        expect(@item.side.id).to eq(Armory::Data::Faction::HORDE)
        expect(@item.side.horde?).to eq(true)
        expect(@item.side.alliance?).to eq(false)
        expect(@item.achievement_points).to be_a Integer
        expect(@item.achievement_points).to eq(2210)
        expect(@item.emblem).to be_a Armory::Data::Emblem
        expect(@item.emblem.icon).to be_a Integer
        expect(@item.emblem.icon).to eq(138)
        expect(@item.emblem.icon_color).to be_a String
        expect(@item.emblem.icon_color).to eq("ff00671f")
        expect(@item.emblem.border).to be_a Integer
        expect(@item.emblem.border).to eq(3)
        expect(@item.emblem.border_color).to be_a String
        expect(@item.emblem.border_color).to eq("ff00671a")
        expect(@item.emblem.background_color).to be_a String
        expect(@item.emblem.background_color).to eq("ff232323")
      end
    end



  end

  describe "from character" do

    before do
      @data = {
          name: "The Best Guild",
          realm: "Ravencrest",
          battlegroup: "Rampage",
          members: 352,
          achievementPoints: 2210,
          emblem: {
              icon: 138,
              iconColor: "ff00671f",
              border: 3,
              borderColor: "ff00671a",
              backgroundColor: "ff232323"
          },
      }
      @item = Armory::Guild.new('US', @data)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@item.attrs).to eq(@data)
      end
    end

    describe '#new' do
      it 'returns Armory::Guild with the correct data' do
        expect(@item).to be_a Armory::Guild
        expect(@item.name).to be_a String
        expect(@item.name).to eq("The Best Guild")
        expect(@item.realm).to be_a Armory::BasicRealm
        expect(@item.realm.name).to eq("Ravencrest")
        expect(@item.battlegroup).to be_a String
        expect(@item.battlegroup).to eq("Rampage")
        expect(@item.member_count).to be_a Integer
        expect(@item.member_count).to eq(352)
        expect(@item.achievement_points).to be_a Integer
        expect(@item.achievement_points).to eq(2210)
        expect(@item.emblem).to be_a Armory::Data::Emblem
        expect(@item.emblem.icon).to be_a Integer
        expect(@item.emblem.icon).to eq(138)
        expect(@item.emblem.icon_color).to be_a String
        expect(@item.emblem.icon_color).to eq("ff00671f")
        expect(@item.emblem.border).to be_a Integer
        expect(@item.emblem.border).to eq(3)
        expect(@item.emblem.border_color).to be_a String
        expect(@item.emblem.border_color).to eq("ff00671a")
        expect(@item.emblem.background_color).to be_a String
        expect(@item.emblem.background_color).to eq("ff232323")
      end
    end



  end


end
