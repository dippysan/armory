require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Item::ArtifactRelics < Armory::MetaMethods
    attr_reader :socket, :context, :bonusLists
    alias_method :bonus_lists, :bonusLists

    object_attr_reader :Item, :itemId, target_alias: :id, method_alias: :item

  end
end
