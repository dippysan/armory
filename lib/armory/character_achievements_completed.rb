require 'equalizer'
require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  class Character::Achievements::Completed < Armory::MetaMethods
    include Equalizer.new(:id)
    include Timestamp

    attr_reader :id, :title, :points, :description, :rewardItems, :icon, :accountWide, :factionId
    alias_method :reward_items, :rewardItems
    alias_method :account_wide, :accountWide
    alias_method :faction_id, :factionId

    alias_method :completed_timestamp, :timestamp

    object_attr_reader :'Character::Achievements::CriteriaList', :criteria


  end
end
