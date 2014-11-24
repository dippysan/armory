require 'armory/meta_methods'

module Armory
  class Character::Glyphs < Armory::MetaMethods

    object_attr_reader_as_array :'Data::Glyph', :major, include_keys: IncludeKey.new(:typeId, nil, Armory::Data::Glyph::MAJOR)
    object_attr_reader_as_array :'Data::Glyph', :minor, include_keys: IncludeKey.new(:typeId, nil, Armory::Data::Glyph::MINOR)

  end
end




