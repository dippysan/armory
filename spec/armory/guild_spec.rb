# coding: utf-8
require 'helper'

describe Armory::Guild do

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
        expect(@item.members).to be_a Integer
        expect(@item.members).to eq(352)
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
