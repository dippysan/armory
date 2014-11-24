# coding: utf-8
require 'helper'

describe Armory::Character::Appearance do

  before do
    @appearance_hash = {
        faceVariation: 0,
        skinColor: 1,
        hairVariation: 3,
        hairColor: 4,
        featureVariation: 2,
        showHelm: false,
        showCloak: true
    }
    @appearance = Armory::Character::Appearance.new(@appearance_hash)
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@appearance.attrs).to eq(@appearance_hash)
    end
  end

  describe '#new' do
    it 'returns Armory::Character::Appearance with the correct data' do
      expect(@appearance).to be_a Armory::Character::Appearance
      expect(@appearance.face_variation).to be_a Integer
      expect(@appearance.face_variation).to eq(0)
      expect(@appearance.skin_color).to be_a Integer
      expect(@appearance.skin_color).to eq(1)
      expect(@appearance.hair_variation).to be_a Integer
      expect(@appearance.hair_variation).to eq(3)
      expect(@appearance.hair_color).to be_a Integer
      expect(@appearance.hair_color).to eq(4)
      expect(@appearance.feature_variation).to be_a Integer
      expect(@appearance.feature_variation).to eq(2)
      expect(@appearance.show_helm?).to be_a FalseClass
      expect(@appearance.show_cloak?).to be_a TrueClass
      expect(@appearance.helm?).to be_a FalseClass
      expect(@appearance.cloak?).to be_a TrueClass
    end
  end


end
