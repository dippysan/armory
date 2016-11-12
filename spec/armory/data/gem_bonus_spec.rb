# coding: utf-8
require 'helper'

describe Armory::Data::GemBonus do

  before do
    @data = {     name: "+35 Multistrike",
                  srcItemId: 115806,
                  requiredSkillId: 0,
                  requiredSkillRank: 1,
                  minLevel: 2,
                  itemLevel: 3
              }


    @item = Armory::Data::GemBonus.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::GemBonus with the correct data' do
      expect(@item).to be_a Armory::Data::GemBonus

      expect(@item.name).to be_a String
      expect(@item.name).to eq("+35 Multistrike")
      expect(@item.source_item).to be_a Armory::Item
      expect(@item.required_skill_id).to be_a Integer
      expect(@item.required_skill_id).to eq(0)
      expect(@item.required_skill_rank).to be_a Integer
      expect(@item.required_skill_rank).to eq(1)
      expect(@item.min_level).to be_a Integer
      expect(@item.min_level).to eq(2)
      expect(@item.item_level).to be_a Integer
      expect(@item.item_level).to eq(3)
    end

  end

end
