require 'armory/error'
require 'armory/utils'
require 'armory/version'

module Armory
  module REST
    class Connection
      include Armory::Utils
      attr_accessor :proxy, :cache, :logging
      attr_writer :user_agent

      URL_PREFIX = 'https://us.api.battle.net'

      # Initializes a new Client object
      #
      # @param options [Hash]
      # @return [Armory::Client]
      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end

      # @return [Hash]
      def connection_options
        @connection_options ||= {
          :builder => middleware,
          :headers => {
            :accept => 'application/json',
            :user_agent => user_agent,
          },
          :request => {
            :open_timeout => 10,
            :timeout => 30,
          },
          :proxy => proxy,
        }
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::RackBuilder]
      def middleware
        @middleware ||= Faraday::RackBuilder.new do |faraday|


          # Encodes as "application/x-www-form-urlencoded" if not already encoded
          faraday.request :url_encoded

          # Handle error responses
          faraday.response :armory_raise_error

          # Parse JSON response bodies
          faraday.response :armory_parse_json

          faraday.response :caching, cache unless cache.nil?

          faraday.response :logger unless logging.nil?

          # Set default HTTP adapter
          faraday.adapter :net_http
        end
      end

      # @return [String]
      def user_agent
        @user_agent ||= "Armory Ruby Gem #{Armory::Version}"
      end

      # Perform an HTTP GET request
      def get(path, params = {})
        request(:get, path, params)
      end

      # Perform an HTTP POST request
      def post(path, params = {})
        request(:post, path, params)
      end

    private

      # Returns a Faraday::Connection object
      #
      # @return [Faraday::Connection]
      def connection
        @connection ||= Faraday.new(URL_PREFIX, connection_options)
      end

      def request(method, path, params = {}, headers = {})
        @params = params
        @headers = headers
        update_headers
        update_params

        connection.send(method.to_sym, path, @params) { |request| request.headers.update(@headers) }.env
        rescue Faraday::Error::TimeoutError, Timeout::Error => error
          raise(Armory::Error::RequestTimeout.new(error))
        rescue Faraday::Error::ClientError, JSON::ParserError => error
          raise(Armory::Error::InvalidJSON.new(error))
      end

      def update_headers
      end

      def update_params
      end

    end
  end
end
