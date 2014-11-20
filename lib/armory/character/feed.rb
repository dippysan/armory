require 'memoizable'
require 'armory/utils'
require 'armory/meta_methods'
require 'armory/enumerable'

module Armory
  class Character::Feed < MetaMethods
    include Armory::Enumerable
    include Armory::Utils
    include Memoizable

    def initialize(attrs = {})
      super

      require 'armory/character/feed/item'
      @collection = attrs.collect do |data|
        Character::Feed::Item.create(data)
      end
    end

  end
end

