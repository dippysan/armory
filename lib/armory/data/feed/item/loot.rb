require 'armory/data/feed/item'

module Armory
  class Data::Feed::Item::Loot < Data::Feed::Item

    attr_reader :itemId
    alias_method :item_id, :itemId

  end
end
