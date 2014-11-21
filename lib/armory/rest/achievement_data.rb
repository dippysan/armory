require 'armory/arguments'
require 'armory/auction'
require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'

module Armory
  module REST
    module AchievementData
      include Armory::REST::Utils
      include Armory::Utils

      # Downloads and parses the requested achievement data file
      #
      # @param options [Hash] A customizable set of options.
      def achievement_data(options = {})
        perform_with_objects(:get, '/wow/data/character/achievements', options, Armory::Achievement::Category, :achievements)
      end

    end
  end
end
