# coding: utf-8
require 'helper'

describe Armory::Character::Achievements do

  def i_to_time(i)
    Time.at(i/1000)
  end

  before do
    @achievements_hash = {
        achievementsCompleted: [9141, 9146, 9618],
        achievementsCompletedTimestamp: [1516270000000, 1616280000000, 1716290000000],
        criteria: [26706, 26801, 26867, 26870],
        criteriaQuantity: [1, 12, 13, 14],
        criteriaTimestamp: [1416313545000, 1516313546000, 1616313547000, 1716313548000],
        criteriaCreated: [1416313542000, 0, 1516313543000, 1616313544000]
       }
    @achievements = Armory::Character::Achievements.new(@achievements_hash)
  end

  describe '#achievements' do
    it 'returns base data' do
      expect(@achievements.achievements_completed).to be_an Array
      expect(@achievements.achievements_completed_timestamp).to be_an Array
      expect(@achievements.criteria).to be_an Array
      expect(@achievements.criteria_quantity).to be_an Array
      expect(@achievements.criteria_timestamp).to be_an Array
      expect(@achievements.criteria_created).to be_an Array

      expect(@achievements.achievements_completed.count).to eq(3)
      expect(@achievements.achievements_completed_timestamp.count).to eq(3)
      expect(@achievements.criteria.count).to eq(4)
      expect(@achievements.criteria_quantity.count).to eq(4)
      expect(@achievements.criteria_timestamp.count).to eq(4)
      expect(@achievements.criteria_created.count).to eq(4)

      expect(@achievements.achievements_completed.first).to be_an Integer
      expect(@achievements.achievements_completed_timestamp.first).to be_an Integer
      expect(@achievements.criteria.first).to be_an Integer
      expect(@achievements.criteria_quantity.first).to be_an Integer
      expect(@achievements.criteria_timestamp.first).to be_an Integer
      expect(@achievements.criteria_created.first).to be_an Integer

      expect(@achievements.achievements_completed.first).to eq(9141)
      expect(@achievements.achievements_completed_timestamp.first).to eq(1516270000000)
      expect(@achievements.criteria.first).to eq(26706)
      expect(@achievements.criteria_quantity.first).to eq(1)
      expect(@achievements.criteria_timestamp.first).to eq(1416313545000)
      expect(@achievements.criteria_created.first).to eq(1416313542000)

      expect(@achievements.achievements_completed.last).to eq(9618)
      expect(@achievements.achievements_completed_timestamp.last).to eq(1716290000000)
      expect(@achievements.criteria.last).to eq(26870)
      expect(@achievements.criteria_quantity.last).to eq(14)
      expect(@achievements.criteria_timestamp.last).to eq(1716313548000)
      expect(@achievements.criteria_created.last).to eq(1616313544000)
    end

    it '.achievements returns array of Armory::Data::Achievement' do
      completed = @achievements.completed
      # expect(completed).to be_an Array # It's not an array, but a Armory::Data::Achievement
      expect(completed.first).to be_a Armory::Data::Achievement
      expect(completed.first.id).to eq(9141)
      expect(completed.first.timestamp).to eq(i_to_time(1516270000000))
    end

    it '.achievement_criteria returns array of Armory::Character::Achievements::Criteria' do
      criteria = @achievements.achievement_criteria
      expect(criteria).to be_an Array
      expect(criteria.first).to be_a Armory::Character::Achievements::Criteria
      expect(criteria.first.id).to eq(26706)
      expect(criteria.first.quantity).to eq(1)
      expect(criteria.first.timestamp).to eq(i_to_time(1416313545000))
      expect(criteria.first.created).to eq(i_to_time(1416313542000))
    end
  end

  describe '.achievements#each' do
    it 'iterates' do
      count = 0
      @achievements.each { count += 1 }
      expect(count).to eq(3)
    end
    context 'with start' do
      it 'iterates' do
        count = 0
        @achievements.each(2) { count += 1 }
        expect(count).to eq(1)
      end
    end
  end

  describe '.achievement_criteria#each' do
    it 'iterates' do
      count = 0
      @achievements.achievement_criteria.each { count += 1 }
      expect(count).to eq(4)
    end
    # achievement_criteria is a regular array, not a mixin ennumerable, so we won't run this test
    # describe 'with start' do
    #   it 'iterates' do
    #     count = 0
    #     @achievements.achievement_criteria.each(2) { count += 1 }
    #     expect(count).to eq(2)
    #   end
    # end
  end

end
