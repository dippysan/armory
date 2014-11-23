# coding: utf-8
require 'helper'

describe Armory::Data::RaidBoss do

  before do
    @data = {
                id: 87420,
                name: "Blackhand",
                lfrKills: 0,
                lfrTimestamp: 1316635189000,
                normalKills: 1,
                normalTimestamp: 1416635189000,
                heroicKills: 2,
                heroicTimestamp: 1516635189000,
                mythicKills: 3,
                mythicTimestamp: 1616635189000
            }
    @item = Armory::Data::RaidBoss.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::RaidBoss with basic data' do
      expect(@item).to be_a Armory::Data::RaidBoss

      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(87420)
      expect(@item.name).to be_a String
      expect(@item.name).to eq("Blackhand")
      expect(@item.lfr_kills).to be_a Integer
      expect(@item.lfr_kills).to eq(0)
      expect(@item.lfr_timestamp).to be_a Time
      expect(@item.lfr_timestamp).to eq(Time.at(1316635189000/1000))
      expect(@item.normal_kills).to be_a Integer
      expect(@item.normal_kills).to eq(1)
      expect(@item.normal_timestamp).to be_a Time
      expect(@item.normal_timestamp).to eq(Time.at(1416635189000/1000))
      expect(@item.heroic_kills).to be_a Integer
      expect(@item.heroic_kills).to eq(2)
      expect(@item.heroic_timestamp).to be_a Time
      expect(@item.heroic_timestamp).to eq(Time.at(1516635189000/1000))
      expect(@item.mythic_kills).to be_a Integer
      expect(@item.mythic_kills).to eq(3)
      expect(@item.mythic_timestamp).to be_a Time
      expect(@item.mythic_timestamp).to eq(Time.at(1616635189000/1000))
    end

  end


end


