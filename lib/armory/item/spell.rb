require 'armory/meta_methods'

module Armory
  class Item::Spell < Armory::Identity
    attr_reader :spellId
    alias_method :id, :spellId

    attr_reader :nCharges, :consumable, :categoryId, :trigger
    alias_method :charges, :nCharges
    alias_method :category_id, :categoryId

    object_attr_reader :'Data::Spell', :spell

  end
end
