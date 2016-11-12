require 'armory/identity.rb'

module Armory
  module Data
    class Spell < Armory::Identity

      attr_reader :name, :icon, :description, :castTime, :cooldown, :range
      alias_method :cast_time, :castTime

    end
  end
end
