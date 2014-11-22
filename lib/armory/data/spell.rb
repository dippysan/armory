require 'armory/identity.rb'

module Armory
  class Data::Spell < Armory::Identity

    attr_reader :name, :icon, :description, :castTime, :cooldown, :range
    alias_method :cast_time, :castTime

  end
end
