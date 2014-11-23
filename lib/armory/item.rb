require 'armory/identity'

module Armory
  class Item < Armory::Identity

    attr_reader :name, :icon, :quality, :itemLevel, :armor, :context, :bonusLists, :slot
    alias_method :item_level, :itemLevel
    alias_method :bonus_lists, :bonusLists
    alias_method :bonus, :bonusLists

    object_attr_reader :'Item::Extra', :tooltipParams, method_alias: :tooltip_params

    object_attr_reader_as_array :'Item::Stat', :stats
    object_attr_reader :'Item::Weapon', :weaponInfo, method_alias: :weapon_info
    alias_method :weapon, :weapon_info
    object_attr_reader :'Item::Extra', :tooltipParams, method_alias: :extra
    alias_method :extras, :extra


  end
end
