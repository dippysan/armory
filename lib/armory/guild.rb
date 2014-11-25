require 'armory/base.rb'
require 'armory/modifiable.rb'
require 'memoizable'

module Armory
  class Guild < Armory::Base
    include Modifiable
    include Memoizable

    attr_reader :name, :battlegroup, :member_count, :achievementPoints, :level
    alias_method :achievement_points, :achievementPoints

    object_attr_reader :BasicRealm, :realm, target_alias: :name
    object_attr_reader :'Data::Emblem', :emblem
    object_attr_reader :'Data::Faction', :side, target_alias: :id
    alias_method :faction, :side

    object_attr_reader :'Data::Achievements', :achievements
    
    def members
      @collection
    end
    memoize :members

    def initialize(region = nil, attrs = {})
      super

      # .members can either be an integer (when called from character())
      #    or list of members (when called from guild_members)
      # So, if members is integer, rename to member_count
      if @attrs.include?(:members) && @attrs.fetch(:members).is_a?(Integer)
        @attrs[:member_count] = @attrs[:members]
        @attrs.delete :members
      end

      @collection = attrs.fetch(:members, []).collect do |data|
        merged_data = data[:character].dup
        merged_data[:rank] = data[:rank]
        Character.new(@region, merged_data)
      end

    end

  end
end
