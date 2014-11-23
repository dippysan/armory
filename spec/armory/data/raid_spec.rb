# coding: utf-8
require 'helper'

describe Armory::Data::Raid do

  before do
    @data = {
            name: "Molten Core",
            lfr: 0,
            normal: 2,
            heroic: 1,
            mythic: 3,
            id: 2717,
            bosses: [{
                id: 11502,
                name: "Ragnaros",
                normalKills: 15,
                normalTimestamp: 1416635189000
            }]
        }
    @item = Armory::Data::Raid.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::Raid with basic data' do
      expect(@item).to be_a Armory::Data::Raid

      expect(@item.name).to be_a String
      expect(@item.name).to eq("Molten Core")
      expect(@item.lfr).to be_a Integer
      expect(@item.lfr).to eq(0)
      expect(@item.normal).to be_a Integer
      expect(@item.normal).to eq(2)
      expect(@item.heroic).to be_a Integer
      expect(@item.heroic).to eq(1)
      expect(@item.mythic).to be_a Integer
      expect(@item.mythic).to eq(3)
      expect(@item.id).to be_a Integer
      expect(@item.id).to eq(2717)
    end

    it 'returns list of Armory::Data::RaidBoss with correct data' do

      expect(@item.bosses).to be_a Array
      expect(@item.bosses.first).to be_a Armory::Data::RaidBoss
      expect(@item.bosses.first.id).to be_a Integer
      expect(@item.bosses.first.id).to eq(11502)
      expect(@item.bosses.first.name).to be_a String
      expect(@item.bosses.first.name).to eq("Ragnaros")
      expect(@item.bosses.first.normal_kills).to be_a Integer
      expect(@item.bosses.first.normal_kills).to eq(15)
      expect(@item.bosses.first.normal_timestamp).to be_a Time
      expect(@item.bosses.first.normal_timestamp).to eq(Time.at(1416635189000/1000))
    end

    it 'enumerates bosses' do
      @item.each.with_index do |boss, i|
        expect(boss).to   eq(@item.bosses[i])
      end
    end

  end


end


