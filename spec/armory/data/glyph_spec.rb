# coding: utf-8
require 'helper'

describe Armory::Data::Glyph do

  before do
    @data = {
            glyph: 183,
            item: 2,
            name: "Glyph of Double Jeopardy",
            icon: "spell_holy_righteousfury",
            typeId: 0
        }

    @item = Armory::Data::Glyph.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Glyph with the correct data' do
      expect(@item).to be_a Armory::Data::Glyph
      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(183)
      expect(@item.glyph).to be_a Integer
      expect(@item.glyph).to eq(183)
      expect(@item.name).to be_a String
      expect(@item.name).to eq("Glyph of Double Jeopardy")
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("spell_holy_righteousfury")
      expect(@item.type_id).to be_a Integer
      expect(@item.type_id).to eq(Armory::Data::Glyph::MAJOR)

      expect(@item.item).to be_a Armory::Item
      expect(@item.item.id).to be_a Integer
      expect(@item.item.id).to eq(2)
      expect(@item.item.name).to be_a String
      expect(@item.item.name).to eq("Glyph of Double Jeopardy")
      expect(@item.minor?).to eq(false)
      expect(@item.major?).to eq(true)
    end

  end

  describe '#==' do
    it 'returns true when ids are the same' do
      item1 = Armory::Data::Glyph.new({ glyph: 1 })
      item2 = Armory::Data::Glyph.new({ glyph: 1 })
      expect(item1 == item2).to be true
    end
    it 'returns false when ids are different' do
      item1 = Armory::Data::Glyph.new({ glyph: 1 })
      item2 = Armory::Data::Glyph.new({ glyph: 2 })
      expect(item1 == item2).to be false
    end
  end

end
