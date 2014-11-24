require 'armory/meta_methods.rb'

module Armory
  module Data
    class ArenaBracket < Armory::MetaMethods

      attr_reader :slug, :rating
      attr_reader :weeklyPlayed, :weeklyWon, :weeklyLost
      attr_reader :seasonPlayed, :seasonWon, :seasonLost
      alias_method :weekly_played, :weeklyPlayed
      alias_method :weekly_won,    :weeklyWon
      alias_method :weekly_lost,   :weeklyLost
      alias_method :season_played, :seasonPlayed
      alias_method :season_won,    :seasonWon
      alias_method :season_lost,   :seasonLost

    end
  end
end
