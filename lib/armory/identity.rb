require 'equalizer'
require 'armory/meta_methods'

module Armory
  class Identity < Armory::MetaMethods
    # Unique ID for item
    include Equalizer.new(:id)

    attr_reader :id

  end
end

