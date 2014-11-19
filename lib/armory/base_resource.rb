require 'armory/meta_methods'

module Armory
  class BaseResource < Armory::MetaMethods
    include Equalizer.new(:id)

    attr_reader :id

  end
end

