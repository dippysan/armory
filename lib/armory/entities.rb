require 'memoizable'
require 'armory/entity/hashtag'
require 'armory/entity/symbol'
require 'armory/entity/uri'

module Armory
  module Entities
    include Memoizable

    # @return [Boolean]
    def entities?
      !@attrs[:entities].nil? && @attrs[:entities].any? { |_, array| array.any? }
    end
    memoize :entities?

    # @note Must include entities in your request for this method to work
    # @return [Array<Armory::Entity::Hashtag>]
    def hashtags
      entities(Entity::Hashtag, :hashtags)
    end
    memoize :hashtags

    # @return [Boolean]
    def hashtags?
      hashtags.any?
    end
    memoize :hashtags?

    # @note Must include entities in your request for this method to work
    # @return [Array<Armory::Entity::Symbol>]
    def symbols
      entities(Entity::Symbol, :symbols)
    end
    memoize :symbols

    # @return [Boolean]
    def symbols?
      symbols.any?
    end
    memoize :symbols?

    # @note Must include entities in your request for this method to work
    # @return [Array<Armory::Entity::URI>]
    def uris
      entities(Entity::URI, :urls)
    end
    memoize :uris
    alias_method :urls, :uris

    # @return [Boolean]
    def uris?
      uris.any?
    end
    alias_method :urls?, :uris?

  private

    # @param klass [Class]
    # @param key2 [Symbol]
    # @param key1 [Symbol]
    def entities(klass, key2, key1 = :entities)
      @attrs.fetch(key1.to_sym, {}).fetch(key2.to_sym, []).collect do |entity|
        klass.new(entity)
      end
    end
  end
end
