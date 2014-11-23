require 'armory/identity'

module Armory
  class Data::Race < Armory::Identity

    attr_reader :mask, :side, :name
    
  end
end

