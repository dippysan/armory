require 'armory/identity.rb'

module Armory
  module Data
    class GemBonus < Armory::MetaMethods

      attr_reader :name, :requiredSkillId, :requiredSkillRank, :minLevel, :itemLevel
      alias_method :required_skill_id, :requiredSkillId
      alias_method :required_skill_rank, :requiredSkillRank
      alias_method :min_level, :minLevel
      alias_method :item_level, :itemLevel

      object_attr_reader :Item, :srcItemId, target_alias: :id, method_alias: :source_item

    end
  end
end
