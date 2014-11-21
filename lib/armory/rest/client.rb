require 'faraday'
require 'json'
require 'timeout'
require 'armory/error'
require 'armory/rest/api'
require 'armory/rest/connection'
require 'armory/rest/response/parse_json'
require 'armory/rest/response/raise_error'
require 'time'

module Armory
  module REST
    # Wrapper for the Armory REST API
    # Handles API key and last_modified header (out of options)
    class Client < Armory::REST::Connection
      include Armory::REST::API

      attr_accessor :api_key

      # Initializes a new Client object
      #
      # @param options [Hash]
      # @return [Armory::Client]
      def initialize(options = {})
        super
        validate_credential_type!
      end

      # @return [Boolean]
      def api_key?
        !!api_key
      end

      # @return [Hash]
      def credentials
        {
          :api_key           => api_key,
        }
      end

      # @return [Boolean]
      def credentials?
        credentials.values.all?
      end

    private

      # Ensures that all credentials set during configuration are of a
      # valid type. Valid types are String.
      #
      # @raise [Armory::Error::ConfigurationError] Error is raised when
      #   supplied Armory credentials are not a String.
      def validate_credential_type!
        credentials.each do |credential, value|
          next if value.nil? || value.is_a?(String)
          fail(Armory::Error::ConfigurationError.new("Invalid #{credential} specified: #{value.inspect} must be a string."))
        end
      end

      def update_headers
        last_modified_key = (:last_modified if @params.key?(:last_modified)) ||
                            (:lastmodified if @params.key?(:lastmodified)) ||
                            (:modified if @params.key?(:modified))
        if last_modified_key
          case last_modified_value = @params.delete(last_modified_key)
          when String
            @headers[:"if-last-modified"] = last_modified_value
          when Time
            @headers[:"if-last-modified"] = last_modified_value.utc.rfc2822
          else
            fail(Armory::Error::IncorrectLastUpdate.new("Unable to coerce Last Modified header #{last_modified_key} (#{last_modified_value}) into String"))
          end
        end
      end        

      def update_params
        super
        @params[:apikey] = api_key
      end

    end
  end
end
