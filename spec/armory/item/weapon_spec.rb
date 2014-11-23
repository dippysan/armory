# coding: utf-8
require 'helper'

describe Armory::Item::Weapon do

  before do
    @data = {
                damage: {
                    min: 305,
                    max: 458,
                    exactMin: 305.0,
                    exactMax: 458.0
                },
                weaponSpeed: 1.8,
                dps: 211.94444
            }
    @item = Armory::Item::Weapon.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns correct data' do
      expect(@item).to be_a Armory::Item::Weapon
      expect(@item.weapon_speed).to be_a Float
      expect(@item.weapon_speed).to eq(1.8)
      expect(@item.speed).to be_a Float
      expect(@item.speed).to eq(1.8)
      expect(@item.dps).to be_a Float
      expect(@item.dps).to eq(211.94444)

      expect(@item.damage).to be_a Armory::Item::WeaponDamage
      expect(@item.damage.min).to be_a Integer
      expect(@item.damage.min).to eq(305)
      expect(@item.damage.max).to be_a Integer
      expect(@item.damage.max).to eq(458)
      expect(@item.damage.exact_min).to be_a Float
      expect(@item.damage.exact_min).to eq(305.0)
      expect(@item.damage.exact_max).to be_a Float
      expect(@item.damage.exact_max).to eq(458.0)
    end

  end


end


