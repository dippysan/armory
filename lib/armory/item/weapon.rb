require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Item::Weapon < Armory::MetaMethods
    include Equalizer.new(:dps)

    attr_reader :weaponSpeed, :dps
    alias_method :weapon_speed, :weaponSpeed
    alias_method :speed, :weaponSpeed

    object_attr_reader :'Item::WeaponDamage', :damage

  end
end
