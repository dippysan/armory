# coding: utf-8
require 'helper'

describe Armory::Character::Achievements::Completed do

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
