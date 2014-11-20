require 'armory/base'
require 'armory/modifiable'
require 'armory/toon_class'

module Armory
  class Character < Armory::Base
    include Armory::Modifiable

    attr_reader :name, :battlegroup, :level, :achievementPoints, :thumbnail, :calcClass, :totalHonorableKills
    object_attr_reader :BasicRealm, :realm, target_alias: :name
    object_attr_reader :ToonClass, :class, target_alias: :id
    object_attr_reader :ToonRace, :race, target_alias: :id
    object_attr_reader :ToonGender, :gender, target_alias: :id
    alias_method :achievement_points, :achievementPoints
    alias_method :calc_class, :calcClass
    alias_method :total_honerable_kills, :totalHonorableKills

    require 'armory/character/achievements'  # here because of recursive require above
    object_attr_reader :'Character::Achievements', :achievements
    object_attr_reader :'Character::Appearance', :appearance
    object_attr_reader :'Character::Feed', :feed

  end
end
