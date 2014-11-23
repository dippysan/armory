require 'armory/identity'
require 'memoizable'

module Armory
  class Data::Gender < Armory::Identity
    include Memoizable

    def name
        @attrs[:id]==0 ? "Male" : "Female"
    end
    memoize :name
    
  end
end

