require 'armory/character_feed_item_achievement'

module Armory
  class Character::Feed::Item::Criteria < Character::Feed::Item::Achievement

    object_attr_reader :'Character::Achievements::Criteria', :criteria, include_keys: :timestamp

  end
end
