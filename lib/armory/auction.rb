require 'armory/base'
require 'armory/modifiable'

module Armory
  class Auction < Armory::Base
    include Armory::Modifiable

    # @return [URL]
    url_attr_reader :url
    # @return [Boolean]

    def initialize(region, attrs = {})
        super(region, attrs.fetch(:files) {|| [] }.first)
    end


end
end
