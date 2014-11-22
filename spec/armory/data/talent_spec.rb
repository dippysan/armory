# coding: utf-8
require 'helper'

describe Armory::Data::Talent do

  before do
    @data = {
              tier: 6,
              column: 1,
              spec: { name: "Arms", role: "DPS", order: 0 },  # populated by talent_flatten
              spell: {
                  id: 152277,
                  name: "Ravager",
                  icon: "warrior_talent_icon_ravager",
                  description: "Throw a whirling axe at the target location that inflicts 2,482 damage to enemies within 6 yards every 1 sec. Lasts 10 sec.",
                  range: "40 yd range",
                  castTime: "Instant",
                  cooldown: "1 min cooldown" }
            }

    @item = Armory::Data::Talent.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Talent with the correct data' do
      expect(@item).to be_a Armory::Data::Talent
      expect(@item.tier).to be_a Integer
      expect(@item.tier).to eq(6)
      expect(@item.column).to be_a Integer
      expect(@item.column).to eq(1)
      expect(@item.spec).to be_a Armory::Data::Spec
      expect(@item.spec.name).to eq("Arms")
    end
    it 'parses spell details' do
      expect(@item.spell).to be_a Armory::Data::Spell
      expect(@item.spell.id).to be_a Integer
      expect(@item.spell.id).to eq(152277)
      expect(@item.spell.name).to be_a String
      expect(@item.spell.name).to eq("Ravager")
      expect(@item.spell.icon).to be_a String
      expect(@item.spell.icon).to eq("warrior_talent_icon_ravager")
      expect(@item.spell.description).to be_a String
      expect(@item.spell.description).to eq("Throw a whirling axe at the target location that inflicts 2,482 damage to enemies within 6 yards every 1 sec. Lasts 10 sec.")
      expect(@item.spell.range).to be_a String
      expect(@item.spell.range).to eq("40 yd range")
      expect(@item.spell.cast_time).to be_a String
      expect(@item.spell.cast_time).to eq("Instant")
      expect(@item.spell.cooldown).to be_a String
      expect(@item.spell.cooldown).to eq("1 min cooldown")
    end

  end

  describe '#==' do
    it 'returns true when tier and column are the same' do
      item1 = Armory::Data::Talent.new({ tier: 1, column: 1 })
      item2 = Armory::Data::Talent.new({ tier: 1, column: 1 })
      expect(item1 == item2).to be true
    end
    it 'returns false when tier and column are different' do
      item1 = Armory::Data::Talent.new({ tier: 1, column: 1 })
      item2 = Armory::Data::Talent.new({ tier: 2, column: 1 })
      expect(item1 == item2).to be false
      item2 = Armory::Data::Talent.new({ tier: 2, column: 2 })
      expect(item1 == item2).to be false
      item2 = Armory::Data::Talent.new({ tier: 1, column: 2 })
      expect(item1 == item2).to be false
    end
  end

end
