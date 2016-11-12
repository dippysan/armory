require 'helper'

describe Armory::Achievement::Category do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#achievement_data' do
    before do
      stub_get('/wow/data/character/achievements')
        .to_return(:body => fixture('achievement_data.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource' do
      @client.achievement_data()
      expect(a_get('/wow/data/character/achievements')).to have_been_made
    end

    describe "returns valid data" do
      before do
        @cat_list = @client.achievement_data()
        @ach = @cat_list[1] # Second entry has sub categories
      end

      it 'category data' do
        expect(@cat_list).to be_a Array
        expect(@cat_list.first).to be_a Armory::Achievement::Category
        expect(@cat_list.first.name).to eq('General')
      end

      it 'achievment data for category' do
        expect(@ach).to be_a Armory::Achievement::Category
        expect(@ach.name).to eq('Quests')
        expect(@ach.achievements).to be_a Array
        expect(@ach.categories).to be_a Array
      end

      it 'sub categories' do
        ach_cat = @ach.categories 
        expect(ach_cat).to be_a Array
        expect(ach_cat.first).to be_a Armory::Achievement::Category
        expect(ach_cat.first.name).to eq('Eastern Kingdoms')
      end

      it 'achievements' do
        ach_ach = @ach.achievements
        expect(ach_ach).to be_a Array
        expect(ach_ach.first).to be_a Armory::Data::Achievement
        expect(ach_ach.first.title).to eq('50 Quests Completed')
      end
    end

  end


end
