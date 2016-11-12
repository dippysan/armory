require 'armory/error'
require 'armory/meta_methods'

module Armory
  class Base < Armory::MetaMethods

    def self.stores_region?
      true
    end

    ruby_attr_reader :region

    # Initializes a new object
    #
    # @param attrs [region:String, Hash]
    # @return [Armory::Base]
    def initialize(region = nil, attrs = {})
      raise(Armory::Error::RegionMissing) if region.nil?
      raise(Armory::Error::RegionMissing) if region && region.class != String
      @region = region
      super(attrs)
    end

  end
end

