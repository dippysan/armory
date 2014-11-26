require 'armory/data/feed/item/achievement'

module Armory
  class Data::Feed::Item::Criteria < Data::Feed::Item::Achievement

    object_attr_reader :'Character::Achievements::Criteria', :criteria, include_keys: IncludeKey.new(:timestamp)

  end
end
