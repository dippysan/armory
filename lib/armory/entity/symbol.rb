require 'armory/meta_methods'

module Armory
  class Symbol < Armory::MetaMethods
    # @return [String]
    attr_reader :text
  end
end
