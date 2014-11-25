require 'armory/base.rb'
require 'armory/modifiable.rb'

module Armory
  class Guild < Armory::Base
    include Modifiable

    attr_reader :name, :battlegroup, :members, :achievementPoints, :level
    alias_method :achievement_points, :achievementPoints

    object_attr_reader :BasicRealm, :realm, target_alias: :name
    object_attr_reader :'Data::Emblem', :emblem
    object_attr_reader :'Data::Faction', :side, target_alias: :id
    alias_method :faction, :side

    object_attr_reader :'Data::Achievements', :achievements

  end
end
