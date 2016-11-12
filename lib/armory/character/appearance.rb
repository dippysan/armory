require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Character::Appearance < Armory::MetaMethods
    include Equalizer.new(:faceVariation, :skinColor, :hairVariation, :hairColor, :featureVariation)

    attr_reader :faceVariation, :skinColor, :hairVariation, :hairColor, :featureVariation
    predicate_attr_reader_with_alias :showCloak, :show_cloak
    alias_method :cloak?, :show_cloak?
    predicate_attr_reader_with_alias :showHelm, :show_helm
    alias_method :helm?, :show_helm?
    alias_method :face_variation, :faceVariation
    alias_method :skin_color, :skinColor
    alias_method :hair_variation, :hairVariation
    alias_method :hair_color, :hairColor
    alias_method :feature_variation, :featureVariation

  end
end
