require 'time'
require 'memoizable'

module Armory
  module Creatable
    include Memoizable

    # Time when the object was created on Armory
    #
    # @return [Time]
    def created_at
      Time.parse(@headers["Last-Modified"]) unless @headers["Last-Modified"].nil?
    end
    memoize :created_at
    alias_method :last_modified, :created_at

    # @return [Boolean]
    def created?
      !!@attrs[:created_at]
    end
    memoize :created?
  end
end
