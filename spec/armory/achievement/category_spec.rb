# coding: utf-8
require 'helper'

describe Armory::Achievement::Category do

  describe "top category level" do

    before do
      @achievement_category_data = {
          :id => 1,
          :name => 'General',
          :categories => [ { id: 2, name: 'Sub Category' } ],
          :achievements => [ { id: 3, title: 'Achievement 1'}],
      }
    end

    describe '#new' do
      it 'returns an Armory::AchievementCategory with the correct data' do
        ach = Armory::Achievement::Category.new(@achievement_category_data)
        expect(ach).to be_a Armory::Achievement::Category
        expect(ach.id).to be_a Integer
        expect(ach.id).to eq(1)
        expect(ach.name).to be_a String
        expect(ach.name).to eq("General")
        expect(ach.categories).to be_a Array
        expect(ach.categories.first).to be_a Armory::Achievement::Category
        expect(ach.categories.first.id).to eq(2)
        expect(ach.categories.first.name).to eq('Sub Category')
        expect(ach.achievements).to be_a Array
        expect(ach.achievements.first).to be_a Armory::Character::Achievements::Completed
        expect(ach.achievements.first.id).to eq(3)
        expect(ach.achievements.first.title).to eq('Achievement 1')
      end
    end
  end

  describe "second category level" do

    before do
      @achievement_category_data = {
          :id => 1,
          :name => 'General',
          :categories => [ { id: 2,
                             name: 'Sub Category',
                             :achievements => [ { id: 3, title: 'Achievement 1'}]
                           } ],
      }
    end

    describe '#new' do
      it 'returns an Armory::AchievementCategory with the correct data' do
        ach = Armory::Achievement::Category.new(@achievement_category_data)
        subcat_ach_array = ach.categories.first.achievements
        expect(subcat_ach_array).to be_a Array
        expect(subcat_ach_array.first).to be_a Armory::Character::Achievements::Completed
        expect(subcat_ach_array.first.id).to eq(3)
        expect(subcat_ach_array.first.title).to eq('Achievement 1')
      end
    end
  end

end
