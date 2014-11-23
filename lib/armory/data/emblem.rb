require 'armory/meta_methods.rb'

module Armory
  module Data
    class Emblem < Armory::MetaMethods

      attr_reader :icon, :iconColor, :border, :borderColor, :backgroundColor
      alias_method :icon_color, :iconColor
      alias_method :border_color, :borderColor
      alias_method :background_color, :backgroundColor

    end
  end
end
