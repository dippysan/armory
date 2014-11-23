# coding: utf-8
require 'helper'

describe Armory::Item::Extra do

  before do
    @data = {
                gem0: 76626,
                gem1: 76627,
                enchant: 5331,
                transmogItem: 71779,
                tinker: 4897
            }
    @item = Armory::Item::Extra.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns correct data' do
      expect(@item).to be_a Armory::Item::Extra
      expect(@item.gem0).to be_a Integer
      expect(@item.gem0).to eq(76626)
      expect(@item.gem1).to be_a Integer
      expect(@item.gem1).to eq(76627)
      expect(@item.enchant).to be_a Integer
      expect(@item.enchant).to eq(5331)
      expect(@item.transmog_item).to be_a Armory::Item
      expect(@item.transmog_item.id).to eq(71779)
      expect(@item.tinker).to be_a Integer
      expect(@item.tinker).to eq(4897)
    end

  end


end


