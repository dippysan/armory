require 'memoizable'
require 'armory/creatable'
require 'armory/null_object'
require 'armory/utils'
require 'armory/base'
require 'armory/realm'
require 'armory/enumerable'

module Armory
  class RealmStatus < Base
    include Armory::Creatable
    include Armory::Enumerable
    include Armory::Utils
    include Memoizable

    # @return [Hash]
    attr_reader :attrs
    alias_method :to_h, :attrs
    alias_method :to_hash, :to_h

    def realms
      @collection
    end

    # Initializes a new RealmStatus object
    #
    # @param attrs [Hash]
    # @return [Armory::RealmStatus]
    def initialize(region, attrs = {})
      super
      @collection = @attrs.fetch(:realms, []).collect do |realm|
        Realm.new(@region, realm)
      end
    end

  private

    # @param klass [Class]
    # @param key1 [Symbol]
    def sub_collection(klass, key1)
      @attrs.fetch(key1.to_sym, []).collect do |item|
        klass.new(@region, item)
      end
    end
  end
end
