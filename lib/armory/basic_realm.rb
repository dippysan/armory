require 'equalizer'
require 'armory/base'

module Armory
  class BasicRealm < Armory::Base
    include Equalizer.new(:region, :slug)
    # @return [String]
    attr_reader :slug


  end
end
