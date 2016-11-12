require 'armory/meta_methods'
require 'armory/enumerable'
require 'memoizable'

module Armory
  class Character::Pets < Armory::MetaMethods
    include Enumerable

    attr_reader :numCollected, :numNotCollected
    alias_method :num_collected, :numCollected
    alias_method :num_not_collected, :numNotCollected

    def collected
      @collection
    end
    memoize :collected

    def initialize(attrs = {})
      super

      @collection = attrs.fetch(:collected, []).collect do |data|
        Armory::Data::Pet.new(data)
      end
      
    end


  end
end




