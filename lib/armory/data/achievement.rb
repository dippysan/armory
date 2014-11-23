require 'equalizer'
require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  module Data
    class Achievement < Armory::MetaMethods
      include Equalizer.new(:id)
      include Timestamp

      attr_reader :id, :title, :points, :description

      alias_method :completed_timestamp, :timestamp

      # From achievement data
      attr_reader :rewardItems, :icon, :factionId, :reward
      alias_method :faction_id, :factionId
      alias_method :reward_items, :rewardItems
      predicate_attr_reader_with_alias :accountWide, :account_wide

      object_attr_reader_as_array :'Character::Achievements::Criteria', :criteria

    end
  end
end
