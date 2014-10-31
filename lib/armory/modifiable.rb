require 'memoizable'

module Armory
  module Modifiable
    include Memoizable

    # Date when the object was last modified on the Armory
    #
    # @return [Time]
    def last_modified
      Time.at(@attrs[:lastModified]/1000) unless @attrs[:lastModified].nil?
    end
    memoize :last_modified
    alias_method :lastmodified, :last_modified

    # @return [Boolean]
    def last_modified?
      !!@attrs[:lastModified]
    end
    memoize :last_modified?
    
    alias_method :lastmodified?, :last_modified?
  end
end
