module Armory
  class Data::Spec < Armory::MetaMethods

    attr_reader :id, :name, :role, :backgroundImage, :icon, :description, :order
    alias_method :background_image, :backgroundImage

  end
end
