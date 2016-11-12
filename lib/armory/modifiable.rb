require 'memoizable'

module Armory
  module Modifiable
    include Memoizable

    # Date when the object was last modified on the Armory
    #
    # @return [Time]
    def last_modified
      return nil if @attrs[:lastModified].nil?
      return nil if @attrs[:lastModified]==0
      Time.at(@attrs[:lastModified]/1000)
    end
    memoize :last_modified
    alias_method :lastmodified, :last_modified
    alias_method :modified, :last_modified

    # @return [Boolean]
    def last_modified?
      !!@attrs[:lastModified]
    end
    memoize :last_modified?
    
    alias_method :lastmodified?, :last_modified?
  end
end
