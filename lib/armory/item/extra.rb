require 'armory/meta_methods'

module Armory
  class Item::Extra < Armory::MetaMethods

    attr_reader :gem0, :gem1, :enchant, :tinker

    object_attr_reader :Item, :transmogItem, target_alias: :id, method_alias: :transmog_item

  end
end
