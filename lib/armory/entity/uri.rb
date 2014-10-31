require 'armory/meta_methods'

module Armory
  class URL < Armory::MetaMethods

    url_attr_reader :url

	  URL = URI
	  Uri = URI # rubocop:disable ConstantName
	  Url = URI # rubocop:disable ConstantName
  end

end
