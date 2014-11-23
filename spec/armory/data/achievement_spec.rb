# coding: utf-8
require 'helper'

describe Armory::Data::Achievement do

  describe "with minimal data: from achievements" do
    before do
      @ach = Armory::Data::Achievement.new(id: 1, timestamp: 1416313542000)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@ach.attrs).to eq(id: 1, timestamp: 1416313542000)
      end
    end

    describe '#new' do
      it 'returns Armory::Data::Achievement with the correct data' do
        expect(@ach).to be_a Armory::Data::Achievement
        expect(@ach.id).to be_a Integer
        expect(@ach.id).to eq(1)
        expect(@ach.timestamp).to be_a Time
        expect(@ach.timestamp).to eq(Time.at(1416313542000/1000))
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

      @ach = Armory::Data::Achievement.new(@ach_data)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@ach.attrs).to eq(@ach_data)
      end
    end

    describe '#new' do
      it 'returns Armory::Data::Achievement with the correct data' do
        expect(@ach).to be_a Armory::Data::Achievement
        expect(@ach.id).to be_a Integer
        expect(@ach.id).to eq(8567)
        expect(@ach.timestamp).to be_a Time
        expect(@ach.timestamp).to eq(Time.at(1016313542000/1000))

        expect(@ach.title).to be_a String
        expect(@ach.title).to eq("Sha of Pride kills (LFR Siege of Orgrimmar)")
        expect(@ach.points).to be_a Integer
        expect(@ach.points).to eq(0)
        expect(@ach.description).to be_a String
        expect(@ach.description).to eq("desc")
        expect(@ach.reward).to be_a String
        expect(@ach.reward).to eq("Reward: Chirping Box")
        expect(@ach.icon).to be_a String
        expect(@ach.icon).to eq("trade_engineering")
        expect(@ach.account_wide?).to be_a FalseClass
        expect(@ach.faction_id).to be_a Integer
        expect(@ach.faction_id).to eq(2)
      end
      it '#criteria returns array of Armory::Character::Achievements::Criteria' do
        expect(@ach.criteria).to be_a Array
        expect(@ach.criteria.count).to eq(2)
        expect(@ach.criteria.first).to be_a Armory::Character::Achievements::Criteria
        expect(@ach.criteria.first.id).to eq(1)
        expect(@ach.criteria.first.max).to eq(1)
        expect(@ach.criteria.first.order_index).to eq(1)
        expect(@ach.criteria.last).to be_a Armory::Character::Achievements::Criteria
        expect(@ach.criteria.last.id).to eq(2)
        expect(@ach.criteria.last.max).to eq(2)
        expect(@ach.criteria.last.order_index).to eq(2)
      end
      skip '#reward_items returns Armory::Item with the correct data' do
        expect(@ach.reward_items).to be_a Armory::ItemList
        expect(@ach.reward_items.count).to eq(2)
        expect(@ach.reward_items.first).to be_a Armory::Item
        expect(@ach.reward_items.first.id).to eq(3)
        expect(@ach.reward_items.first.name).to eq("Chirping Box")
        expect(@ach.reward_items.last).to be_a Armory::Item
        expect(@ach.reward_items.last.id).to eq(4)
        expect(@ach.reward_items.last.name).to eq("Basket")
      end
    end
  end
end
