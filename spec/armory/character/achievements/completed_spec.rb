# coding: utf-8
require 'helper'

describe Armory::Character::Achievements::Completed do

  describe "with minimal data: from achievements" do
    before do
      @completed_achievement = Armory::Character::Achievements::Completed.new(id: 1, timestamp: 1416313542000)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@completed_achievement.attrs).to eq(id: 1, timestamp: 1416313542000)
      end
    end

    describe '#new' do
      it 'returns Armory::Character::Achievements::Completed with the correct data' do
        expect(@completed_achievement).to be_a Armory::Character::Achievements::Completed
        expect(@completed_achievement.id).to be_a Integer
        expect(@completed_achievement.id).to eq(1)
        expect(@completed_achievement.timestamp).to be_a Time
        expect(@completed_achievement.timestamp).to eq(Time.at(1416313542000/1000))
      end
    end
  end

  describe "with full data: from feed" do
    before do
      @ach_data = { 
                id: 8567,
                timestamp: 1016313542000, # Note timestamp not in source data. Pulled from feed item
                title: "Sha of Pride kills (LFR Siege of Orgrimmar)",
                points: 0,
                description: "desc",
                reward: "Reward: Chirping Box",
                rewardItems: [{ id: 3, name: "Chirping Box" }, { id: 4, name: "Basket" }],
                icon: "trade_engineering",
                criteria: [{ id: 1, orderIndex: 1, max: 1}, {id: 2, orderIndex: 2, max: 2}],
                accountWide: false,
                factionId: 2
            }

      @completed_achievement = Armory::Character::Achievements::Completed.new(@ach_data)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@completed_achievement.attrs).to eq(@ach_data)
      end
    end

    describe '#new' do
      it 'returns Armory::Character::Achievements::Completed with the correct data' do
        expect(@completed_achievement).to be_a Armory::Character::Achievements::Completed
        expect(@completed_achievement.id).to be_a Integer
        expect(@completed_achievement.id).to eq(8567)
        expect(@completed_achievement.timestamp).to be_a Time
        expect(@completed_achievement.timestamp).to eq(Time.at(1016313542000/1000))

        expect(@completed_achievement.title).to be_a String
        expect(@completed_achievement.title).to eq("Sha of Pride kills (LFR Siege of Orgrimmar)")
        expect(@completed_achievement.points).to be_a Integer
        expect(@completed_achievement.points).to eq(0)
        expect(@completed_achievement.description).to be_a String
        expect(@completed_achievement.description).to eq("desc")
        expect(@completed_achievement.reward).to be_a String
        expect(@completed_achievement.reward).to eq("Reward: Chirping Box")
        expect(@completed_achievement.icon).to be_a String
        expect(@completed_achievement.icon).to eq("trade_engineering")
        expect(@completed_achievement.account_wide?).to be_a FalseClass
        expect(@completed_achievement.faction_id).to be_a Integer
        expect(@completed_achievement.faction_id).to eq(2)
      end
      it '#criteria returns array of Armory::Character::Achievements::Criteria' do
        expect(@completed_achievement.criteria).to be_a Array
        expect(@completed_achievement.criteria.count).to eq(2)
        expect(@completed_achievement.criteria.first).to be_a Armory::Character::Achievements::Criteria
        expect(@completed_achievement.criteria.first.id).to eq(1)
        expect(@completed_achievement.criteria.first.max).to eq(1)
        expect(@completed_achievement.criteria.first.order_index).to eq(1)
        expect(@completed_achievement.criteria.last).to be_a Armory::Character::Achievements::Criteria
        expect(@completed_achievement.criteria.last.id).to eq(2)
        expect(@completed_achievement.criteria.last.max).to eq(2)
        expect(@completed_achievement.criteria.last.order_index).to eq(2)
      end
      skip '#reward_items returns Armory::Item with the correct data' do
        expect(@completed_achievement.reward_items).to be_a Armory::ItemList
        expect(@completed_achievement.reward_items.count).to eq(2)
        expect(@completed_achievement.reward_items.first).to be_a Armory::Item
        expect(@completed_achievement.reward_items.first.id).to eq(3)
        expect(@completed_achievement.reward_items.first.name).to eq("Chirping Box")
        expect(@completed_achievement.reward_items.last).to be_a Armory::Item
        expect(@completed_achievement.reward_items.last.id).to eq(4)
        expect(@completed_achievement.reward_items.last.name).to eq("Basket")
      end
    end
  end
end
