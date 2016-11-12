require 'armory/identity'

module Armory
  module Data
    class Race < Armory::Identity

      attr_reader :mask, :side, :name
    
    end
  end
end

