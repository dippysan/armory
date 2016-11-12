# coding: utf-8
require 'helper'

describe Armory::Data::Emblem do

  before do
    @data = {
            icon: 138,
            iconColor: "ff00671f",
            border: 3,
            borderColor: "ff00671a",
            backgroundColor: "ff232323"
    }
    @item = Armory::Data::Emblem.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Emblem with the correct data' do
      expect(@item).to be_a Armory::Data::Emblem
      expect(@item.icon).to be_a Integer
      expect(@item.icon).to eq(138)
      expect(@item.icon_color).to be_a String
      expect(@item.icon_color).to eq("ff00671f")
      expect(@item.border).to be_a Integer
      expect(@item.border).to eq(3)
      expect(@item.border_color).to be_a String
      expect(@item.border_color).to eq("ff00671a")
      expect(@item.background_color).to be_a String
      expect(@item.background_color).to eq("ff232323")
    end
  end



end

