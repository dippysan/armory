require 'armory/error'
require 'armory/utils'
require 'armory/version'

module Armory
  class Client
    include Armory::Utils
    attr_accessor :api_key, :proxy
    attr_writer :user_agent

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Armory::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      validate_credential_type!
    end

    # @return [Boolean]
    def api_key?
      !!api_key
    end

    # @return [String]
    def user_agent
      @user_agent ||= "Armory Ruby Gem #{Armory::Version}"
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
