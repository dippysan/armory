require 'addressable/uri'
require 'armory/arguments'
require 'armory/request'
require 'armory/rest/connection'
require 'armory/utils'
require 'armory/basic_realm'

module Armory
  module REST
    module Utils
      include Armory::Utils
      URI_SUBSTRING = '://'
      DEFAULT_CURSOR = -1

      # Take a realm slug, or Armory::BasicRealm object and return its slug
      #
      # @param object [String, Armory::BasicRealm] A slug or object.
      # @return [String]
      def extract_slug(object)
        case object
          when ::String;           object
          when Armory::BasicRealm; object.slug
          else raise (Armory::Error::InvalidRealm)
        end
      end

      # Take an auction url string, URL, or Armory::Auction object and return the URL as a string
      #
      # @param object [String, Armory::BasicRealm] A slug or object.
      # @return [String]
      def extract_url(object)
        case object
          when Addressable::URI; object.to_s
          when ::String;         Addressable::URI.parse(object).to_s
          when Armory::Auction;  object.url.to_s
        end
      end

    private

      # # Take a URI string or Armory::Identity object and return its ID
      # #
      # # @param object [Integer, String, URI, Armory::Identity] An ID, URI, or object.
      # # @return [Integer]
      # def extract_id(object)
      #   case object
      #   when ::Integer
      #     object
      #   when ::String
      #     object.split('/').last.to_i
      #   when URI
      #     object.path.split('/').last.to_i
      #   when Armory::Identity
      #     object.id
      #   end
      # end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_with_object(request_method, path, options, klass)
        request = Armory::Request.new(self, request_method, path, options)
        request.perform_with_object(klass)
      end

      # Same as above, but uses RequestBare so not to include any locale or region
      def perform_bare_with_object(request_method, path, options, klass)
        request = Armory::RequestBare.new(self, request_method, path, options)
        request.perform_with_object(klass)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      # @param inital_key [String] - If exists, uses this key of returned json.
      #                              Used because Bliz never returns arrays alone
      def perform_with_objects(request_method, path, options, klass, initial_key = nil)
        request = Armory::Request.new(self, request_method, path, options)
        request.perform_with_objects(klass, initial_key)
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array]
      def parallel_objects_from_response(klass, request_method, path, args)
        arguments = Armory::Arguments.new(args)
        pmap(arguments) do |object|
          perform_with_object(request_method, path, arguments.options.merge(:id => extract_id(object)), klass)
        end
      end

    end
  end
end
