# coding: utf-8
require 'helper'

describe Armory::Character::Talents do

  before do
    @data = {
        calcTalent: "000022.",
        calcSpec: "b",
        calcGlyph: "SjMpKO",
        selected: true,
        spec: {
            name: "Protection",
            role: "TANK",
            backgroundImage: "bg-warrior-protection",
            icon: "ability_warrior_defensivestance",
            description: "A stalwart protector who uses a shield to safeguard himself and his allies.",
            order: 2
        },
        talents: [{
            tier: 4,
            column: 2,
            spell: {
                id: 114030,
                name: "Vigilance",
                icon: "ability_warrior_vigilance",
                description: "Protect a party or raid member for 12 sec, reducing damage they take by 30% and allowing you to use Taunt with no cooldown.",
                range: "40 yd range",
                castTime: "Instant",
                cooldown: "2 min cooldown"
            }
        }, {tier: 1, column: 0, spell: {id: 55694 }
        }, {tier: 0, column: 0, spell: {id: 103826 }
        }, {tier: 2, column: 0, spell: {id: 169680 }
        }, {tier: 3, column: 0, spell: {id: 107570 }
        }, {tier: 5, column: 2, spell: {id: 46924 }
        }],
        glyphs: {
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
        },
    }
    @item = Armory::Character::Talents.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::Talents with basic data' do
      expect(@item).to be_a Armory::Character::Talents

      expect(@item.calc_talent).to be_a String
      expect(@item.calc_talent).to eq("000022.")
      expect(@item.calc_spec).to be_a String
      expect(@item.calc_spec).to eq("b")
      expect(@item.calc_glyph).to be_a String
      expect(@item.calc_glyph).to eq("SjMpKO")
      expect(@item.selected?).to be_a TrueClass
      expect(@item.selected?).to eq(true)

      expect(@item.talents).to be_a Array
      expect(@item.glyphs).to be_a Armory::Character::Glyphs

    end

    it 'returns Armory::Data::Spec' do
      expect(@item.spec).to be_a Armory::Data::Spec
      expect(@item.spec.name).to be_a String
      expect(@item.spec.name).to eq("Protection")
      expect(@item.spec.role).to be_a String
      expect(@item.spec.role).to eq("TANK")
      expect(@item.spec.background_image).to be_a String
      expect(@item.spec.background_image).to eq("bg-warrior-protection")
      expect(@item.spec.icon).to be_a String
      expect(@item.spec.icon).to eq("ability_warrior_defensivestance")
      expect(@item.spec.description).to be_a String
      expect(@item.spec.description).to eq("A stalwart protector who uses a shield to safeguard himself and his allies.")
      expect(@item.spec.order).to be_a Integer
      expect(@item.spec.order).to eq(2)

    end

    it 'returns Armory::Data::Talent' do
      expect(@item.talents.first).to be_a Armory::Data::Talent
      expect(@item.talents.first.tier).to be_a Integer
      expect(@item.talents.first.tier).to eq(4)
      expect(@item.talents.first.column).to be_a Integer
      expect(@item.talents.first.column).to eq(2)
      expect(@item.talents.first.spell).to be_a Armory::Data::Spell
      expect(@item.talents.first.spell.name).to eq("Vigilance")
    end
    
    it 'returns Armory::Data::Glyph' do
      expect(@item.glyphs.major).to be_a Array
      expect(@item.glyphs.major.first).to be_a Armory::Data::Glyph
      expect(@item.glyphs.major.first.id).to be_a Integer
      expect(@item.glyphs.major.first.id).to eq(502)
      expect(@item.glyphs.major.first.item).to be_a Armory::Item
      expect(@item.glyphs.major.first.item.id).to be_a Integer
      expect(@item.glyphs.major.first.item.id).to eq(43425)
      expect(@item.glyphs.major.first.item.name).to be_a String
      expect(@item.glyphs.major.first.item.name).to eq("Glyph of Shield Slam")

      expect(@item.glyphs.minor).to be_a Array
      expect(@item.glyphs.minor.first).to be_a Armory::Data::Glyph
      expect(@item.glyphs.minor.first.id).to be_a Integer
      expect(@item.glyphs.minor.first.id).to eq(991)
      expect(@item.glyphs.minor.first.item).to be_a Armory::Item
      expect(@item.glyphs.minor.first.item.id).to be_a Integer
      expect(@item.glyphs.minor.first.item.id).to eq(80588)
      expect(@item.glyphs.minor.first.item.name).to be_a String
      expect(@item.glyphs.minor.first.item.name).to eq("Glyph of Burning Anger")
    end

  end


end


