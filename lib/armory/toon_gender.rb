require 'armory/base_resource'
require 'memoizable'

module Armory
  class ToonGender < Armory::BaseResource
    include Memoizable

    def name
        @attrs[:id]==0 ? "Male" : "Female"
    end
    memoize :name
    
  end
end

