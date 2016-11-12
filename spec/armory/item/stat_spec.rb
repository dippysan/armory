# coding: utf-8
require 'helper'

describe Armory::Item::Stat do

  before do
    @data = {
                stat: 51,
                amount: 63
            }
    @item = Armory::Item::Stat.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns correct data' do
      expect(@item).to be_a Armory::Item::Stat
      expect(@item.stat).to be_a Integer
      expect(@item.stat).to eq(51)
      expect(@item.amount).to be_a Integer
      expect(@item.amount).to eq(63)
    end

  end


end


