# coding: utf-8
require 'helper'

describe Armory::Item do

  before do
    @data = {
            id: 118941,
            name: "Crown of Woe",
            icon: "inv_crown_02",
            quality: 4,
            itemLevel: 640,
            tooltipParams: {  # From character items
                gem0: 76626,
                gem1: 76627,
                enchant: 5331,
                transmogItem: 71779,
                tinker: 4897
            },
            stats: [{  # From character items?
                stat: 51,
                amount: 63
            }, {
                stat: 32,
                amount: 139
            }],
            armor: 114,
            weaponInfo: {
                damage: {
                    min: 305,
                    max: 458,
                    exactMin: 305.0,
                    exactMax: 458.0
                },
                weaponSpeed: 1.8,
                dps: 211.94444
            },
            context: "vendor",
            bonusLists: [41, 524],

          # Returned from /wow/item/999
          description: "Matches any socket.",
          stackable: 20,
          itemBind: 0,
          bonusStats: [],
          itemSpells: [
            { spellId: 7418,
              spell: {
                id: 7418,
                name: "Minor Health",
                icon: "spell_holy_greaterheal",
                description: "Permanently enchant bracers to increase health by 5. Cannot be applied to items higher than level 600.",
                castTime: "1.5 sec cast"
              },
              nCharges: 1,
              consumable: true,
              categoryId: 0,
              trigger: "ON_USE"
            }
          ],
          buyPrice: 160000,
          itemClass: 3,
          itemSubClass: 8,
          containerSlots: 0,
          gemInfo: {
              bonus: {
                  name: "+35 Multistrike",
                  srcItemId: 115806,
                  requiredSkillId: 0,
                  requiredSkillRank: 0,
                  minLevel: 0,
                  itemLevel: 1
              },
              type: {
                  type: "PRISMATIC"
              },
              minItemLevel: 600
          },
          inventoryType: 0,
          equippable: false,
          maxCount: 0,
          maxDurability: 0,
          minFactionId: 0,
          minReputation: 0,
          sellPrice: 40000,
          requiredSkill: 0,
          requiredLevel: 1,
          requiredSkillRank: 0,
          itemSource: {
              sourceId: 170722,
              sourceType: "CREATED_BY_SPELL"
          },
          baseArmor: 0,
          hasSockets: false,
          isAuctionable: true,
          displayInfoId: 0,
          nameDescription: "",
          nameDescriptionColor: "000000",
          upgradable: true,
          heroicTooltip: false,
          availableContexts: [""],
          bonusSummary: {
              defaultBonusLists: [],
              chanceBonusLists: [],
              bonusChances: []
          },

          # Artifact Weapon
              :artifactId => 48,
    :artifactAppearanceId => 120,
          :artifactTraits => [{:id => 1342, :rank => 1},
                              {:id => 1186, :rank => 3},
                              {:id => 972, :rank => 3}
                             ],
                  :relics => [{ :socket => 0, :itemId => 133006, :context => 11, :bonusLists => [768, 1525, 1809] },
                              { :socket => 1, :itemId => 133058, :context => 11, :bonusLists => [1793, 1545, 1809] }
                             ]
        }
    @item = Armory::Item.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns simple data' do
      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(118941)
      expect(@item.name).to be_a String
      expect(@item.name).to eq("Crown of Woe")
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("inv_crown_02")
      expect(@item.quality).to be_a Integer
      expect(@item.quality).to eq(4)
      expect(@item.item_level).to be_a Integer
      expect(@item.item_level).to eq(640)
      expect(@item.armor).to be_a Integer
      expect(@item.armor).to eq(114)
      expect(@item.context).to be_a String
      expect(@item.context).to eq("vendor")
      expect(@item.is_relic?).to eq false
    end

    it 'returns additional data from /wow/items call' do

      expect(@item.description).to eq("Matches any socket.")
      expect(@item.stackable).to eq(20)
      expect(@item.item_bind).to eq(0)
      expect(@item.bonus_stats).to eq([])
      expect(@item.spells).to be_a Array
      expect(@item.buy_price).to eq(160000)
      expect(@item.item_class).to eq(3)
      expect(@item.item_sub_class).to eq(8)
      expect(@item.container_slots).to eq(0)
      expect(@item.gem_info).to be_a Armory::Data::GemInfo
      expect(@item.inventory_type).to eq(0)
      expect(@item.equippable?).to eq(false)
      expect(@item.max_count).to eq(0)
      expect(@item.max_durability).to eq(0)
      expect(@item.min_faction_id).to eq(0)
      expect(@item.min_reputation).to eq(0)
      expect(@item.sell_price).to eq(40000)
      expect(@item.required_skill).to eq(0)
      expect(@item.required_level).to eq(1)
      expect(@item.required_skill_rank).to eq(0)
      expect(@item.item_source).to eq({sourceId: 170722, sourceType: "CREATED_BY_SPELL"})
      expect(@item.base_armor).to eq(0)
      expect(@item.sockets?).to eq(false)
      expect(@item.auctionable?).to eq(true)
      expect(@item.display_info_id).to eq(0)
      expect(@item.name_description).to eq("")
      expect(@item.name_description_color).to eq("000000")
      expect(@item.upgradable?).to eq(true)
      expect(@item.heroic_tooltip?).to eq(false)
      expect(@item.available_contexts).to eq([""])
      expect(@item.bonus_summary).to eq({defaultBonusLists: [], chanceBonusLists: [], bonusChances: []})
    end

    it 'returns artifact weapon data' do
      expect(@item.artifact_id).to eq(48)
      expect(@item.artifact_appearance_id).to eq(120)
    end

    it 'returns correct spell data' do
      expect(@item.spells).to be_a Array
      itemspell = @item.spells.first
      expect(itemspell).to be_a Armory::Item::Spell
      expect(itemspell.id).to be_a Integer
      expect(itemspell.id).to eq(7418)
      expect(itemspell.charges).to be_a Integer
      expect(itemspell.charges).to eq(1)
      expect(itemspell.consumable).to be_a TrueClass
      expect(itemspell.consumable).to eq(true)
      expect(itemspell.category_id).to be_a Integer
      expect(itemspell.category_id).to eq(0)
      expect(itemspell.trigger).to be_a String
      expect(itemspell.trigger).to eq("ON_USE")

      expect(itemspell.spell).to be_a Armory::Data::Spell
      expect(itemspell.spell.id).to be_a Integer
      expect(itemspell.spell.id).to eq(7418)
      expect(itemspell.spell.name).to be_a String
      expect(itemspell.spell.name).to eq("Minor Health")
      expect(itemspell.spell.icon).to be_a String
      expect(itemspell.spell.icon).to eq("spell_holy_greaterheal")
      expect(itemspell.spell.description).to be_a String
      expect(itemspell.spell.description).to eq("Permanently enchant bracers to increase health by 5. Cannot be applied to items higher than level 600.")
      expect(itemspell.spell.cast_time).to be_a String
      expect(itemspell.spell.cast_time).to eq("1.5 sec cast")

    end

    it 'returns extra data' do
      expect(@item.bonus_lists).to be_a Array
      expect(@item.bonus_lists).to eq([41, 524])

      expect(@item.bonus).to be_a Array
      expect(@item.bonus.first).to eq(41) 

    end

    it 'returns extra data' do
      expect(@item.extras).to be_a Armory::Item::Extra
      expect(@item.extra).to be_a Armory::Item::Extra
      expect(@item.extra.gem0).to be_a Integer
      expect(@item.extra.gem0).to eq(76626)
      expect(@item.extra.gem1).to be_a Integer
      expect(@item.extra.gem1).to eq(76627)
      expect(@item.extra.enchant).to be_a Integer
      expect(@item.extra.enchant).to eq(5331)
      expect(@item.extra.transmog_item).to be_a Armory::Item
      expect(@item.extra.transmog_item.id).to eq(71779)
      expect(@item.extra.tinker).to be_a Integer
      expect(@item.extra.tinker).to eq(4897)
    end

    it 'returns stats data' do
      expect(@item.stats).to be_a Array
      expect(@item.stats.first).to be_a Armory::Item::Stat
      expect(@item.stats.first.stat).to be_a Integer
      expect(@item.stats.first.stat).to eq(51)
      expect(@item.stats.first.amount).to be_a Integer
      expect(@item.stats.first.amount).to eq(63)
    end

    it 'returns weapon data' do
      expect(@item.weapon_info).to be_a Armory::Item::Weapon

      expect(@item.weapon).to be_a Armory::Item::Weapon
      expect(@item.weapon.weapon_speed).to be_a Float
      expect(@item.weapon.weapon_speed).to eq(1.8)
      expect(@item.weapon.speed).to be_a Float
      expect(@item.weapon.speed).to eq(1.8)
      expect(@item.weapon.dps).to be_a Float
      expect(@item.weapon.dps).to eq(211.94444)

      expect(@item.weapon.damage).to be_a Armory::Item::WeaponDamage
      expect(@item.weapon.damage.min).to be_a Integer
      expect(@item.weapon.damage.min).to eq(305)
      expect(@item.weapon.damage.max).to be_a Integer
      expect(@item.weapon.damage.max).to eq(458)
      expect(@item.weapon.damage.exact_min).to be_a Float
      expect(@item.weapon.damage.exact_min).to eq(305.0)
      expect(@item.weapon.damage.exact_max).to be_a Float
      expect(@item.weapon.damage.exact_max).to eq(458.0)
    end

    it 'returns artifact extra data' do
      expect(@item.artifact_traits).to be_a Array
      expect(@item.artifact_traits.first).to be_a Armory::Item::ArtifactTraits
      expect(@item.artifact_traits.first.id).to eq(1342)
      expect(@item.artifact_traits.first.rank).to eq(1)
      expect(@item.artifact_relics).to be_a Array
      expect(@item.artifact_relics.first).to be_a Armory::Item::ArtifactRelics
      expect(@item.artifact_relics.first.socket).to eq(0)
      expect(@item.artifact_relics.first.item).to be_a Armory::Item
      expect(@item.artifact_relics.first.item.id).to eq(133006)
      expect(@item.artifact_relics.first.context).to eq(11)
      expect(@item.artifact_relics.first.bonus_lists).to be_a Array
      expect(@item.artifact_relics.first.bonus_lists).to eq([768, 1525, 1809])
    end

    describe "relic item" do
      before do
        # Replace gemdata with relic
        @data[:gemInfo] = {
                bonus: {
                    name: "Relic Enhancement",
                    srcItemId: 0,
                    requiredSkillId: 0,
                    requiredSkillRank: 0,
                    minLevel: 0,
                    itemLevel: 1
                },
                type: {
                    type: "IRON"
                },
                minItemLevel: 0
            }
        @item = Armory::Item.new(@data)
      end

      it 'senses relic items' do
        expect(@item.is_relic?).to eq true
        expect(@item.relic_type).to eq "IRON"
      end

    end


  end


end


