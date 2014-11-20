# coding: utf-8
require 'helper'

describe Armory::Character::Achievements::Criteria do

  describe "with data from achievements" do
    before do
      @criteria_achievement = Armory::Character::Achievements::Criteria.new(id:1, quantity:2, timestamp:1416313542000, created:1415832272000 )
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@criteria_achievement.attrs).to eq(id:1, quantity:2, timestamp:1416313542000, created:1415832272000)
      end
    end

    describe '#new' do
      it 'returns Armory::Character::Achievements::Criteria with the correct data' do
        expect(@criteria_achievement).to be_a Armory::Character::Achievements::Criteria
        expect(@criteria_achievement.id).to be_a Integer
        expect(@criteria_achievement.id).to eq(1)
        expect(@criteria_achievement.quantity).to be_a Integer
        expect(@criteria_achievement.quantity).to eq(2)
        expect(@criteria_achievement.timestamp).to be_a Time
        expect(@criteria_achievement.timestamp).to eq(Time.at(1416313542000/1000))
        expect(@criteria_achievement.created).to be_a Time
        expect(@criteria_achievement.created).to eq(Time.at(1415832272000/1000))
      end
    end
  end

  describe "with data from feed" do

    before do
                  
      @criteria_achievement = Armory::Character::Achievements::Criteria.new(
          id: 23803, timestamp: 1416313542000, description: "desc", orderIndex: 0, max: 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@criteria_achievement.attrs).to eq(id: 23803, timestamp:1416313542000, description: "desc", orderIndex: 0, max: 1)
      end
    end

    describe '#new' do
      it 'returns Armory::Character::Achievements::Criteria with the correct data' do
        expect(@criteria_achievement).to be_a Armory::Character::Achievements::Criteria
        expect(@criteria_achievement.id).to be_a Integer
        expect(@criteria_achievement.id).to eq(23803)
        expect(@criteria_achievement.timestamp).to be_a Time
        expect(@criteria_achievement.timestamp).to eq(Time.at(1416313542000/1000))
        expect(@criteria_achievement.description).to be_a String
        expect(@criteria_achievement.description).to eq("desc")
        expect(@criteria_achievement.order_index).to be_a Integer
        expect(@criteria_achievement.order_index).to eq(0)
        expect(@criteria_achievement.max).to be_a Integer
        expect(@criteria_achievement.max).to eq(1)
      end
    end
  end

end
