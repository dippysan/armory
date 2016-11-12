require 'armory/meta_methods.rb'

module Armory
  module Data
    class PetStats < Armory::MetaMethods
      # include Equalizer.new(:item_id)

      attr_reader :speciesId, :breedId, :petQualityId, :level, :health, :power, :speed
      alias_method :pet_quality_id, :petQualityId
      alias_method :quality, :petQualityId
      alias_method :species_id, :speciesId
      alias_method :breed_id, :breedId

    end
  end
end
