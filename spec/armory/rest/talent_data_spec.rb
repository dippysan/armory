require 'helper'

describe Armory::REST::TalentData do

  before do
    @client = Armory::REST::Client.new(api_key: "API")
  end

  describe '#achievement_data' do
    before do
      stub_get('/wow/data/talents')
        .to_return(:body => fixture('talent_data.json'),
                   :headers => {:content_type => 'application/json; charset=utf-8'})
    end
    it 'requests the correct resource' do
      @client.talent_data()
      expect(a_get('/wow/data/talents')).to have_been_made
    end

    it 'json returns bare data' do
      expect(@client.talent_data_json()).to eq(fixture_as_json('talent_data.json'))
    end

    describe "returns valid data" do
      before do
        @class_list = @client.talent_data()
        @warrior = @client.talent_data().first
        @hunter = @client.talent_data()[2] # Class 3
      end

      it 'returns warrior data first' do
        expect(@class_list).to be_a Array
        expect(@class_list.first).to be_a Armory::Data::ToonClass
        expect(@class_list.first.id).to eq(1)
        expect(@class_list.first.name).to eq('warrior')
      end

      it 'returns druid data last' do
        expect(@class_list).to be_a Array
        expect(@class_list.last).to be_a Armory::Data::ToonClass
        expect(@class_list.last.id).to eq(11)
        expect(@class_list.last.name).to eq('druid')
      end

      it 'glyph data for a class' do
        glyph = @warrior.glyphs
        expect(glyph).to be_a Array
        expect(glyph.first).to be_a Armory::Data::Glyph
        expect(glyph.first.id).to eq(483)
        expect(glyph.first.name).to eq("Glyph of Mystic Shout")
        expect(glyph.last.id).to eq(1188)
        expect(glyph.last.name).to eq("Glyph of Flawless Defense")
      end

      it 'talent data for a class' do
        talent = @warrior.talents
        expect(talent).to be_a Array
        expect(talent.first.first.first).to be_a Armory::Data::Talent
        expect(talent.first.first.first.spell.name).to eq("Juggernaut")
      end

      it 'flattened talent data for a class' do
        talent = @warrior.talents_flatten
        expect(talent).to be_a Array
        expect(talent.count).to eq(27)
        expect(talent.first).to be_a Armory::Data::Talent
        expect(talent.first.spell.name).to eq("Juggernaut")
        expect(talent.last).to be_a Armory::Data::Talent
        expect(talent.last.spell.name).to eq("Siegebreaker")
      end

      it 'petspec data for hunter' do
        spec = @hunter.pet_specs
        expect(spec).to be_a Array
        expect(spec.first).to be_a Armory::Data::Spec
        expect(spec.first.name).to eq("Ferocity")
        expect(spec.first.role).to eq("DPS")
        expect(spec.last.name).to eq("Cunning")
        expect(spec.last.role).to eq("DPS")
      end

    end

  end


end
