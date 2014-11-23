require 'armory/meta_methods.rb'

module Armory
  class Guild < Armory::Base

    attr_reader :name, :battlegroup, :members, :achievementPoints
    alias_method :achievement_points, :achievementPoints

    object_attr_reader :BasicRealm, :realm, target_alias: :name
    object_attr_reader :'Data::Emblem', :emblem


  end
end
