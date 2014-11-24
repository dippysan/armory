# coding: utf-8
require 'helper'

describe Armory::Data::ArenaBracket do

  before do
    @data = {
                slug: "2v2",
                rating: 1945,
                weeklyPlayed: 0,
                weeklyWon: 1,
                weeklyLost: 2,
                seasonPlayed: 856,
                seasonWon: 438,
                seasonLost: 418
            }
    @item = Armory::Data::ArenaBracket.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Data::ArenaBracket with valid data' do
      expect(@item).to be_a Armory::Data::ArenaBracket

      expect(@item.slug).to be_a String
      expect(@item.slug).to eq("2v2")
      expect(@item.rating).to be_a Integer
      expect(@item.rating).to eq(1945)
      expect(@item.weekly_played).to be_a Integer
      expect(@item.weekly_played).to eq(0)
      expect(@item.weekly_won).to be_a Integer
      expect(@item.weekly_won).to eq(1)
      expect(@item.weekly_lost).to be_a Integer
      expect(@item.weekly_lost).to eq(2)
      expect(@item.season_played).to be_a Integer
      expect(@item.season_played).to eq(856)
      expect(@item.season_won).to be_a Integer
      expect(@item.season_won).to eq(438)
      expect(@item.season_lost).to be_a Integer
      expect(@item.season_lost).to eq(418)

    end

  end


end


