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

    # from /wow/item/999
    attr_reader :description, :stackable, :itemBind, :bonusStats, :buyPrice, :itemClass, :itemSubClass
    attr_reader :containerSlots, :gemInfo, :inventoryType, :maxCount, :maxDurability, :minFactionId, :minReputation
    attr_reader :sellPrice, :requiredSkill, :requiredLevel, :requiredSkillRank, :itemSource, :baseArmor
    attr_reader :displayInfoId, :nameDescription, :nameDescriptionColor, :availableContexts, :bonusSummary

    object_attr_reader_as_array :'Item::Spell', :itemSpells, method_alias: :spells

    alias_method :item_bind, :itemBind
    alias_method :bonus_stats, :bonusStats
    alias_method :buy_price, :buyPrice
    alias_method :item_class, :itemClass
    alias_method :item_sub_class, :itemSubClass
    alias_method :container_slots, :containerSlots
    alias_method :gem_info, :gemInfo
    alias_method :inventory_type, :inventoryType
    alias_method :max_count, :maxCount
    alias_method :max_durability, :maxDurability
    alias_method :min_faction_id, :minFactionId
    alias_method :min_reputation, :minReputation
    alias_method :sell_price, :sellPrice
    alias_method :required_skill, :requiredSkill
    alias_method :required_level, :requiredLevel
    alias_method :required_skill_rank, :requiredSkillRank
    alias_method :item_source, :itemSource
    alias_method :base_armor, :baseArmor
    alias_method :display_info_id, :displayInfoId
    alias_method :name_description, :nameDescription
    alias_method :name_description_color, :nameDescriptionColor
    alias_method :available_contexts, :availableContexts
    alias_method :bonus_summary, :bonusSummary

    predicate_attr_reader :equippable, :upgradable
    predicate_attr_reader_with_alias :isAuctionable, :auctionable
    predicate_attr_reader_with_alias :heroicTooltip, :heroic_tooltip
    predicate_attr_reader_with_alias :hasSockets, :sockets

    object_attr_reader :'Data::GemInfo', :gemInfo, method_alias: :gem_info

  end
end
