require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'
require 'set'

module Armory
  module REST
    module Item
      include Armory::REST::Utils
      include Armory::Utils

      # The item API provides detailed item information. This includes item set information if
      # this item is part of a set.
      #
      # @return [Armory::Item] Item Information
      # @param item_id [integer | Armory::Item]
      # @param options [Hash] A customizable set of options.
      #  - fields: the dataset to retrieve
      def item(item_id, options = {})
        options = options.dup
        perform_with_object(:get, URI.escape("/wow/item/#{item_id}"),
          options, Armory::Item)
      end

      def item_json(item_id, options = {})
        options = options.dup
        perform(:get, URI.escape("/wow/item/#{item_id}"),
          options)
      end

    end
  end
end
