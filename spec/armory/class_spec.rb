# coding: utf-8
require 'helper'

describe Armory::Data::ToonClass do

  describe "top class level" do

    before do
      @talent_class_data = {
          :id => 1,
          :class => 'Warrior',
          :glyphs => [ { glyph: 483, item: 43395, name: "Glyph of Mystic Shout", typeId: 1 } ],
          :talents => [
                        [
                          [{
                              tier: 0,
                              column: 1,
                              spell: {
                                  id: 103826,
                                  name: "Juggernaut",
                                  icon: "ability_warrior_bullrush",
                                  description: "You can Charge every 12 sec instead of every 20 sec.",
                                  castTime: "Passive"
                              }
                          }]]],
          :specs => [ { name: "Arms", role: "DPS", order: 0 } ],
          :petSpecs => [ { name: "Ferocity", order: 0 }, { name: "Tenacity", order: 1 } ],
      }
      @data_class = Armory::Data::ToonClass.new(@talent_class_data)
    end

    describe '#new' do
      it 'returns an Armory::Data::ToonClass with the correct data' do
        expect(@data_class).to be_a Armory::Data::ToonClass
        expect(@data_class.id).to be_a Integer
        expect(@data_class.id).to eq(1)
        expect(@data_class.classname).to be_a String
        expect(@data_class.classname).to eq("Warrior")
      end

      it 'correctly parses glyphs' do
        expect(@data_class.glyphs).to be_a Array
        expect(@data_class.glyphs.first).to be_a Armory::Data::Glyph
        expect(@data_class.glyphs.first.id).to eq(483)
        expect(@data_class.glyphs.first.name).to eq('Glyph of Mystic Shout')
      end

      it 'correctly parses talents' do
        expect(@data_class.talents).to be_a Array
        expect(@data_class.talents.first).to be_a Array
        expect(@data_class.talents.first.first).to be_a Array
        first_talent = @data_class.talents.first.first.first
        expect(first_talent).to be_a Armory::Data::Talent
        expect(first_talent.tier).to eq(0)
        expect(first_talent.column).to eq(1)
        expect(first_talent.spell).to be_a Armory::Data::Spell
        expect(first_talent.spell.id).to eq(103826)
        expect(first_talent.spell.name).to eq("Juggernaut")
      end

      it 'correctly flattens talents' do
        expect(@data_class.talents_flatten).to be_a Array
        expect(@data_class.talents_flatten.first).to be_a Armory::Data::Talent
        expect(@data_class.talents_flatten.first.tier).to eq(0)
        expect(@data_class.talents_flatten.first.column).to eq(1)
        expect(@data_class.talents_flatten.first.spell).to be_a Armory::Data::Spell
        expect(@data_class.talents_flatten.first.spell.id).to eq(103826)
        expect(@data_class.talents_flatten.first.spell.name).to eq("Juggernaut")
      end

      it 'correctly parses specs' do
        expect(@data_class.specs).to be_a Array
        expect(@data_class.specs.first).to be_a Armory::Data::Spec
        expect(@data_class.specs.first.name).to eq("Arms")
        expect(@data_class.specs.first.role).to eq("DPS")
        expect(@data_class.specs.first.order).to eq(0)
      end

      it 'correctly parses pet specs' do
        expect(@data_class.pet_specs).to be_a Array
        expect(@data_class.pet_specs.first).to be_a Armory::Data::Spec
        expect(@data_class.pet_specs.first.name).to eq("Ferocity")
        expect(@data_class.pet_specs.first.order).to eq(0)
      end
    end
  end

  describe '#==' do
    it 'returns true when ids are the same' do
      item1 = Armory::Data::ToonClass.new({ id: 1 })
      item2 = Armory::Data::ToonClass.new({ id: 1 })
      expect(item1 == item2).to be true
    end
    it 'returns false when ids are different' do
      item1 = Armory::Data::ToonClass.new({ id: 1 })
      item2 = Armory::Data::ToonClass.new({ id: 2 })
      expect(item1 == item2).to be false
    end
  end

  describe "flattens talents into array" do

    before do
      @data = {
          :id => 1,
          :class => 'Warrior',
          :specs => [ { name: "Spec 1", order: 0 }, { name: "Spec 2", order: 1 } ],
          :talents => [
                        [
                          [{ tier: 0,  column: 0, }, { tier: 0,  column: 0, }],
                          [{ tier: 0,  column: 1, }, { tier: 0,  column: 0, }],
                          [{ tier: 0,  column: 2, }]
                        ], [
                          [{ tier: 1,  column: 0, }],
                          [{ tier: 1,  column: 1, }],
                          [{ tier: 1,  column: 2, }]
                        ], [
                          [{ tier: 2,  column: 0, }],
                          [{ tier: 2,  column: 1, }],
                          [{ tier: 2,  column: 2, }, { tier: 2,  column: 2 }]
                        ]
                      ]
                    }

      @data_class = Armory::Data::ToonClass.new(@data)
    end

    describe '#new' do
      it 'returns valid class data' do
        expect(@data_class).to be_a Armory::Data::ToonClass
        expect(@data_class.classname).to be_a String
        expect(@data_class.classname).to eq("Warrior")
      end

      it 'returns flattened talents' do
        flattened_talents = @data_class.talents_flatten
        expect(flattened_talents).to be_a Array
        expect(flattened_talents.count).to eq(12)
        expect(flattened_talents.first).to be_a Armory::Data::Talent
        expect(flattened_talents.first.tier).to eq(0)
        expect(flattened_talents.first.column).to eq(0)
        expect(flattened_talents.last).to be_a Armory::Data::Talent
        expect(flattened_talents.last.tier).to eq(2)
        expect(flattened_talents.last.column).to eq(2)
      end
      it 'inserts specs into flattened talents' do
        flattened_talents = @data_class.talents_flatten
        expect(flattened_talents.first).to be_a Armory::Data::Talent
        expect(flattened_talents.first.spec).to be_a Armory::Data::Spec
        expect(flattened_talents.first.spec.name).to eq("Spec 1")
        expect(flattened_talents.last).to be_a Armory::Data::Talent
        expect(flattened_talents.last.spec).to be_a Armory::Data::Spec
        expect(flattened_talents.last.spec.name).to eq("Spec 2")
      end
    end
  end



end
