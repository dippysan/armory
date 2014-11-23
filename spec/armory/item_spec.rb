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
            tooltipParams: {
                gem0: 76626,
                gem1: 76627,
                enchant: 5331,
                transmogItem: 71779,
                tinker: 4897
            },
            stats: [{
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
            bonusLists: [41, 524]
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

  end


end


