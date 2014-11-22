# coding: utf-8
require 'helper'

describe Armory::Data::Spell do

  before do
    @data = {
              id: 74001,
              name: "Combat Readiness",
              icon: "ability_rogue_combatreadiness",
              description: "Enter a state of heightened defensive awareness. Each successive weapon attack will deal 10% less damage, stacking 5 times.  Lasts 20 sec or until not attacked with weapons for 10 sec.",
              range: "Melee Range",
              castTime: "Instant",
              cooldown: "2 min cooldown"
            }

    @item = Armory::Data::Spell.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Spell with the correct data' do
      expect(@item).to be_a Armory::Data::Spell
      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(74001)
      expect(@item.name).to be_a String
      expect(@item.name).to eq("Combat Readiness")
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("ability_rogue_combatreadiness")
      expect(@item.description).to be_a String
      expect(@item.description).to eq("Enter a state of heightened defensive awareness. Each successive weapon attack will deal 10% less damage, stacking 5 times.  Lasts 20 sec or until not attacked with weapons for 10 sec.")
      expect(@item.range).to be_a String
      expect(@item.range).to eq("Melee Range")
      expect(@item.cast_time).to be_a String
      expect(@item.cast_time).to eq("Instant")
      expect(@item.cooldown).to be_a String
      expect(@item.cooldown).to eq("2 min cooldown")
    end

  end

  describe '#==' do
    it 'returns true when ids are the same' do
      item1 = Armory::Data::Spell.new({ id: 1 })
      item2 = Armory::Data::Spell.new({ id: 1 })
      expect(item1 == item2).to be true
    end
    it 'returns false when ids are different' do
      item1 = Armory::Data::Spell.new({ id: 1 })
      item2 = Armory::Data::Spell.new({ id: 2 })
      expect(item1 == item2).to be false
    end
  end

end
