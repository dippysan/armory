require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'
require 'set'

module Armory
  module REST
    module Character
      include Armory::REST::Utils
      include Armory::Utils

      # The Character Profile API is the primary way to access character information. This Character
      # Profile API can be used to fetch a single character at a time through an HTTP GET request to a
      # URL describing the character profile resource. By default, a basic dataset will be returned and
      # with each request and zero or more additional fields can be retrieved. To access this API, craft
      # a resource URL pointing to the character who's information is to be retrieved.
      #
      # @return [Armory::Character] Character Information
      # @param realm_slug [string | Armory::Realm]
      # @param character_name [string ]
      # @param options [Hash] A customizable set of options.
      #  - fields: the dataset to retrieve
      def character(realm_slug, character_name, options = {})
        perform_with_object(:get, "/wow/character/#{extract_slug(realm_slug)}/#{character_name}",
          options, Armory::Character)
      end

      def character_achievements(realm_slug, character_name, options = {})
        insert_fields_value(options, "achievements")
        character(realm_slug, character_name, options)
      end

      def character_appearance(realm_slug, character_name, options = {})
        insert_fields_value(options, "appearance")
        character(realm_slug, character_name, options)
      end

      def character_feed(realm_slug, character_name, options = {})
        insert_fields_value(options, "feed")
        character(realm_slug, character_name, options)
      end

      def character_guild(realm_slug, character_name, options = {})
        insert_fields_value(options, "guild")
        character(realm_slug, character_name, options)
      end

      def character_items(realm_slug, character_name, options = {})
        insert_fields_value(options, "items")
        character(realm_slug, character_name, options)
      end

      def character_mounts(realm_slug, character_name, options = {})
        insert_fields_value(options, "mounts")
        character(realm_slug, character_name, options)
      end

      def character_pets(realm_slug, character_name, options = {})
        insert_fields_value(options, "pets")
        character(realm_slug, character_name, options)
      end

      def character_progression(realm_slug, character_name, options = {})
        insert_fields_value(options, "progression")
        character(realm_slug, character_name, options)
      end

      def character_pvp(realm_slug, character_name, options = {})
        insert_fields_value(options, "pvp")
        character(realm_slug, character_name, options)
      end

      def character_talents(realm_slug, character_name, options = {})
        insert_fields_value(options, "talents")
        character(realm_slug, character_name, options)
      end

    end
  end
end
