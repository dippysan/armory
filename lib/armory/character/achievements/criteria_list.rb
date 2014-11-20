require 'armory/character/achievements/criteria'
require 'armory/enumerable'

module Armory
  class Character::Achievements::CriteriaList < Armory::MetaMethods
    include Armory::Enumerable

    def initialize(attrs = {})
      super

      @collection = (attrs || []).collect do |data|
        Character::Achievements::Criteria.new(data)
      end
    end

  end
end
