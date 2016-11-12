require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Item::ArtifactTraits < Armory::Identity
    include Equalizer.new(:id, :rank)

    attr_reader :rank

  end
end
