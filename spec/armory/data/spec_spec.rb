# coding: utf-8
require 'helper'

describe Armory::Data::Spec do

  before do
    @data = {
            id: 1, # Populated by toonclass when flatenning talents
            name: "Arms",
            role: "DPS",
            backgroundImage: "bg-warrior-arms",
            icon: "ability_warrior_savageblow",
            description: "A battle-hardened master of two-handed weapons, using mobility and overpowering attacks to strike his opponents down.",
            order: 0
        }

    @item = Armory::Data::Spec.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Spec with the correct data' do
      expect(@item).to be_a Armory::Data::Spec
      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(1)
      expect(@item.name).to be_a String
      expect(@item.name).to eq("Arms")
      expect(@item.role).to be_a String
      expect(@item.role).to eq("DPS")
      expect(@item.background_image).to be_a String
      expect(@item.background_image).to eq("bg-warrior-arms")
      expect(@item.icon).to be_a String
      expect(@item.icon).to eq("ability_warrior_savageblow")
      expect(@item.description).to be_a String
      expect(@item.description).to eq("A battle-hardened master of two-handed weapons, using mobility and overpowering attacks to strike his opponents down.")
      expect(@item.order).to be_a Integer
      expect(@item.order).to eq(0)
    end

  end

end
