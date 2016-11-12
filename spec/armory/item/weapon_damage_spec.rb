# coding: utf-8
require 'helper'

describe Armory::Item::WeaponDamage do

  before do
    @data = {
                    min: 305,
                    max: 458,
                    exactMin: 305.0,
                    exactMax: 458.0
                }
    @item = Armory::Item::WeaponDamage.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns correct data' do
      expect(@item).to be_a Armory::Item::WeaponDamage
      expect(@item.min).to be_a Integer
      expect(@item.min).to eq(305)
      expect(@item.max).to be_a Integer
      expect(@item.max).to eq(458)
      expect(@item.exact_min).to be_a Float
      expect(@item.exact_min).to eq(305.0)
      expect(@item.exact_max).to be_a Float
      expect(@item.exact_max).to eq(458.0)
    end

  end


end


