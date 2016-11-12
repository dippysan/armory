require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Item::WeaponDamage < Armory::MetaMethods
    include Equalizer.new(:min, :max, :exactMin, :exactMax)

    attr_reader :min, :max, :exactMin, :exactMax
    alias_method :exact_max, :exactMax
    alias_method :exact_min, :exactMin

  end
end
