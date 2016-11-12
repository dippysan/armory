require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Item::Stat < Armory::MetaMethods
    include Equalizer.new(:stat, :amount)

    attr_reader :stat, :amount

  end
end
