require 'armory/base'

module Armory
  class Entity < Armory::MetaMethods
    # @return [Array<Integer>]
    attr_reader :indices
  end
end
