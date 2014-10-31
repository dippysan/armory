module Armory
  class Arguments < Array
    # @return [Hash]
    attr_reader :options

    # Initializes a new Arguments object
    #
    # @return [Armory::Arguments]
    def initialize(args)
      @options = args.last.is_a?(::Hash) ? args.pop : {}
      super(args.flatten)
    end
  end
end
