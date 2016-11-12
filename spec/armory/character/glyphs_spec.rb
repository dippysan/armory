# coding: utf-8
require 'helper'

describe Armory::Character::Glyphs do

  before do
    @data = {
            major: [{
                glyph: 502,
                item: 43425,
                name: "Glyph of Shield Slam",
                icon: "inv_shield_05"
            }, {
                glyph: 508,
                item: 0,
                name: "Glyph of Victory Rush",
                icon: "ability_warrior_devastate"
            }, { glyph: 931}],
            minor: [{
                glyph: 991,
                item: 80588,
                name: "Glyph of Burning Anger",
                icon: "spell_shadow_unholyfrenzy"
            }, { glyph: 1020 }, {
                 glyph: 765  }]
        }
    @item = Armory::Character::Glyphs.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::Glyphs with basic data' do
      expect(@item).to be_a Armory::Character::Glyphs

      expect(@item.major).to be_a Array
      expect(@item.major.first).to be_a Armory::Data::Glyph
      expect(@item.major.first.id).to be_a Integer
      expect(@item.major.first.id).to eq(502)
      expect(@item.major.first.type_id).to eq(Armory::Data::Glyph::MAJOR)
      expect(@item.major.first.minor?).to eq(false)
      expect(@item.major.first.major?).to eq(true)
      expect(@item.major.first.item).to be_a Armory::Item
      expect(@item.major.first.item.id).to be_a Integer
      expect(@item.major.first.item.id).to eq(43425)
      expect(@item.major.first.item.name).to be_a String
      expect(@item.major.first.item.name).to eq("Glyph of Shield Slam")

      expect(@item.minor).to be_a Array
      expect(@item.minor.first).to be_a Armory::Data::Glyph
      expect(@item.minor.first.id).to be_a Integer
      expect(@item.minor.first.id).to eq(991)
      expect(@item.minor.first.type_id).to eq(Armory::Data::Glyph::MINOR)
      expect(@item.minor.first.minor?).to eq(true)
      expect(@item.minor.first.major?).to eq(false)
      expect(@item.minor.first.item).to be_a Armory::Item
      expect(@item.minor.first.item.id).to be_a Integer
      expect(@item.minor.first.item.id).to eq(80588)
      expect(@item.minor.first.item.name).to be_a String
      expect(@item.minor.first.item.name).to eq("Glyph of Burning Anger")
    end

  end


end


