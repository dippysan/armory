require 'armory/entity'

module Armory
  class Entity
    class Hashtag < Armory::Entity
      # @return [String]
      attr_reader :text
    end
  end
end
