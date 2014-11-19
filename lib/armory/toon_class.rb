require 'armory/base_resource'

module Armory
  class ToonClass < Armory::BaseResource

    attr_reader :mask, :powerType, :name
    alias_method :power_type, :powerType

  end
end

