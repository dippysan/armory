require 'armory/base'
require 'armory/modifiable'
require 'armory/data/toon_class'

module Armory
  class Character < Armory::Base
    include Armory::Modifiable

    attr_reader :name, :battlegroup, :level, :achievementPoints, :thumbnail, :calcClass, :totalHonorableKills

    alias_method :achievement_points, :achievementPoints
    alias_method :calc_class, :calcClass
    alias_method :total_honerable_kills, :totalHonorableKills

    object_attr_reader :BasicRealm, :realm, target_alias: :name
    object_attr_reader :'Data::ToonClass', :class, target_alias: :id
    object_attr_reader :'Data::Race', :race, target_alias: :id
    object_attr_reader :'Data::Gender', :gender, target_alias: :id

    object_attr_reader :'Character::Achievements', :achievements
    object_attr_reader :'Character::Appearance', :appearance
    object_attr_reader_as_array :'Character::Feed::Item', :feed
    object_attr_reader :Guild, :guild

  end
end
