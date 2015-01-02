# coding: utf-8
require 'helper'

describe Armory::Data::GemInfo do

  before do
    @data = {
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
          }


    @item = Armory::Data::GemInfo.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::GemInfo with the correct data' do
      expect(@item).to be_a Armory::Data::GemInfo

      expect(@item.bonus).to be_a Armory::Data::GemBonus

      expect(@item.type).to be_a String
      expect(@item.type).to eq("PRISMATIC")
      expect(@item.min_item_level).to be_a Integer
      expect(@item.min_item_level).to eq(600)
    end

  end

end
