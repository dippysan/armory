require 'base64'
require 'faraday'
require 'json'
require 'timeout'
require 'armory/client'
require 'armory/error'
require 'armory/rest/api'
require 'armory/rest/connection'
require 'armory/rest/response/parse_json'
require 'armory/rest/response/raise_error'

module Armory
  module REST
    # Wrapper for the Armory REST API
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

      def request_params(params = {})
        params[:apikey] = api_key
        params
      end

    end
  end
end
