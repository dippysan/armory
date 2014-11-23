require 'armory/identity'
require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  class Armory::Achievement; end
  class Armory::Achievement::Category < Armory::Identity
    include Timestamp

    attr_reader :name

    object_attr_reader_as_array :'Armory::Achievement::Category', :categories
    object_attr_reader_as_array :'Data::Achievement', :achievements

  end
end
