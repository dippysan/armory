require 'armory/character/feed/item'

module Armory
  class Character::Feed::Item::BossKill < Character::Feed::Item

    attr_reader :name, :quantity
    predicate_attr_reader_with_alias :featOfStrength, :feat_of_strength

    object_attr_reader :'Data::Achievement', :achievement, include_keys: :timestamp
    object_attr_reader :'Character::Achievements::Criteria', :criteria, include_keys: :timestamp

  end
end
