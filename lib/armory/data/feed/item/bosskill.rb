require 'armory/data/feed/item'

module Armory
  class Data::Feed::Item::BossKill < Data::Feed::Item

    attr_reader :name, :quantity
    predicate_attr_reader_with_alias :featOfStrength, :feat_of_strength

    object_attr_reader :'Data::Achievement', :achievement, include_keys: IncludeKey.new(:timestamp)
    object_attr_reader :'Data::AchievementCriteria', :criteria, include_keys: IncludeKey.new(:timestamp)

  end
end
