require 'equalizer'
require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  class Armory::Achievement; end
  class Armory::Achievement::Category < Armory::MetaMethods
    include Equalizer.new(:id)
    include Timestamp

    attr_reader :id, :name

    object_attr_reader_as_array :'Armory::Achievement::Category', :categories
    object_attr_reader_as_array :'Armory::Character::Achievements::Completed', :achievements

  end
end
