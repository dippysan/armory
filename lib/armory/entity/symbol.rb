require 'armory/entity'

module Armory
  class Entity
    class Symbol < Armory::Entity
      # @return [String]
      attr_reader :text
    end
  end
end
