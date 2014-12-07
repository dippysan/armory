require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'
require 'set'
require 'uri'

module Armory
  module REST
    module Guild
      include Armory::REST::Utils
      include Armory::Utils

      # The guild profile API is the primary way to access guild information. This guild profile API
      # can be used to fetch a single guild at a time through an HTTP GET request to a url describing
      # the guild profile resource. By default, a basic dataset will be returned and with each request
      # and zero or more additional fields can be retrieved.
      #
      # @return [Armory::Guild] Guild Information
      # @param realm_slug [string | Armory::Realm]
      # @param guild_name [string ]
      # @param options [Hash] A customizable set of options.
      #  - fields: the dataset to retrieve
      def guild(realm_slug, guild_name, options = {})
        options = options.dup
        perform_with_object(:get, URI.escape("/wow/guild/#{extract_slug(realm_slug)}/#{guild_name}"),
          options, Armory::Guild)
      end

      def guild_achievements(realm_slug, guild_name, options = {})
        options = insert_fields_value(options.dup, "achievements")
        guild(realm_slug, guild_name, options)
      end

      def guild_members(realm_slug, guild_name, options = {})
        options = insert_fields_value(options.dup, "members")
        guild(realm_slug, guild_name, options)
      end

      def guild_news(realm_slug, guild_name, options = {})
        options = insert_fields_value(options.dup, "news")
        guild(realm_slug, guild_name, options)
      end

    end
  end
end
