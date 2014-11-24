# coding: utf-8
require 'helper'

describe Armory::Character::PvP do

  before do
    @data = {
            ARENA_BRACKET_2v2: {
                slug: "2v2",
                rating: 1945,
                weeklyPlayed: 0,
                weeklyWon: 1,
                weeklyLost: 2,
                seasonPlayed: 856,
                seasonWon: 438,
                seasonLost: 418
            },
            ARENA_BRACKET_3v3: {
                slug: "3v3",
                rating: 2711,
                weeklyPlayed: 3,
                weeklyWon: 4,
                weeklyLost: 5,
                seasonPlayed: 252,
                seasonWon: 149,
                seasonLost: 103
            },
            ARENA_BRACKET_5v5: { slug: "5v5" },
            ARENA_BRACKET_RBG: { slug: "rbg" },
            UNKNOWN:           { slug: "unknown"}
        }
    @item = Armory::Character::PvP.new(@data)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@item.attrs).to eq(@data)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::PvP with links to arena data' do
      expect(@item).to be_a Armory::Character::PvP

      expect(@item.arena_bracket_2v2).to be_a Armory::Data::ArenaBracket
      expect(@item.arena_bracket_3v3).to be_a Armory::Data::ArenaBracket
      expect(@item.arena_bracket_5v5).to be_a Armory::Data::ArenaBracket
      expect(@item.arena_bracket_rbg).to be_a Armory::Data::ArenaBracket
      expect(@item.unknown).to be_a Armory::Data::ArenaBracket

      expect(@item.v2).to be_a Armory::Data::ArenaBracket
      expect(@item.v3).to be_a Armory::Data::ArenaBracket
      expect(@item.v5).to be_a Armory::Data::ArenaBracket
      expect(@item.rbg).to be_a Armory::Data::ArenaBracket

    end

    it '#v2 returns Armory::Data::PvP with correct data' do
      two = @item.v2

      expect(two.slug).to be_a String
      expect(two.slug).to eq("2v2")
      expect(two.rating).to be_a Integer
      expect(two.rating).to eq(1945)
      expect(two.weekly_played).to be_a Integer
      expect(two.weekly_played).to eq(0)
      expect(two.weekly_won).to be_a Integer
      expect(two.weekly_won).to eq(1)
      expect(two.weekly_lost).to be_a Integer
      expect(two.weekly_lost).to eq(2)
      expect(two.season_played).to be_a Integer
      expect(two.season_played).to eq(856)
      expect(two.season_won).to be_a Integer
      expect(two.season_won).to eq(438)
      expect(two.season_lost).to be_a Integer
      expect(two.season_lost).to eq(418)

    end

    it '#v3 returns Armory::Data::PvP with correct data' do
      three = @item.v3

      expect(three.slug).to be_a String
      expect(three.slug).to eq("3v3")
      expect(three.rating).to be_a Integer
      expect(three.rating).to eq(2711)
      expect(three.weekly_played).to be_a Integer
      expect(three.weekly_played).to eq(3)
      expect(three.weekly_won).to be_a Integer
      expect(three.weekly_won).to eq(4)
      expect(three.weekly_lost).to be_a Integer
      expect(three.weekly_lost).to eq(5)
      expect(three.season_played).to be_a Integer
      expect(three.season_played).to eq(252)
      expect(three.season_won).to be_a Integer
      expect(three.season_won).to eq(149)
      expect(three.season_lost).to be_a Integer
      expect(three.season_lost).to eq(103)

    end

    it '#v5, #rbg, #unknown returns Armory::Data::PvP with correct data' do
      expect(@item.v5.slug).to be_a String
      expect(@item.v5.slug).to eq("5v5")
      expect(@item.rbg.slug).to be_a String
      expect(@item.rbg.slug).to eq("rbg")
      expect(@item.unknown.slug).to be_a String
      expect(@item.unknown.slug).to eq("unknown")

    end

    it 'enumerates PvP' do
      
      @item.each.with_index do |pvp, i|
        expect(pvp.slug).to eq(Armory::Character::PvP::ARENA_ORDER_SLUG[i])
      end
    end

  end


end


