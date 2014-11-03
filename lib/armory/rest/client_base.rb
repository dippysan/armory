require 'base64'
require 'faraday'
require 'json'
require 'timeout'
require 'armory/client'
require 'armory/error'
require 'armory/rest/api'
require 'armory/rest/response/parse_json'
require 'armory/rest/response/raise_error'
#require 'dalli'

## HACK: Monkey-patch middleware to return full URL rather than just URI part for caching
# module FaradayMiddleware
#   # Public: Caches GET responses and pulls subsequent ones from the cache.
#   class Caching < Faraday::Middleware
#     def cache_key(env)
#       url = env[:url].dup
#       if url.query && params_to_ignore.any?
#         params = parse_query url.query
#         params.reject! {|k,| params_to_ignore.include? k }
#         url.query = params.any? ? build_query(params) : nil
#       end
#       url.normalize!
#       url.to_s
#     end
#   end
# end

module Armory
  module REST
    # Wrapper for the Armory REST API
    class ClientBase < Armory::Client
      include Armory::REST::API
      PROTOCOL = 'https://'
      BATTLENET = '.api.battle.net'
      URL_PREFIX = PROTOCOL+'us'+BATTLENET
      ENDPOINT = URL_PREFIX

      attr_writer :user_agent, :proxy

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

#          faraday.response :caching, Dalli::Client.new('localhost:11211', { :namespace => "armory", :compress => true, :expires_in => 60*60 }), :ignore_params => %w[access_token]

          faraday.response :logger  
          # Set default HTTP adapter
          faraday.adapter :net_http
        end
      end

      # Perform an HTTP GET request
      def get(path, params = {})
        headers = request_headers
        params = request_params(params)
        request(:get, path, params, headers)
      end

      # Perform an HTTP POST request
      def post(path, params = {})
        headers = request_headers
        params = request_params(params)
        request(:post, path, params, headers)
      end

      # @return [String]
      def user_agent
        @user_agent ||= "Armory Ruby Gem #{Armory::Version}"
      end

    private

      # Returns a Faraday::Connection object
      #
      # @return [Faraday::Connection]
      def connection
        @connection ||= Faraday.new(URL_PREFIX, connection_options)
      end

      def request(method, path, params = {}, headers = {})
        connection.send(method.to_sym, path, params) { |request| request.headers.update(headers) }.env
      rescue Faraday::Error::TimeoutError, Timeout::Error => error
        raise(Armory::Error::RequestTimeout.new(error))
      rescue Faraday::Error::ClientError, JSON::ParserError => error
        raise(Armory::Error.new(error))
      end

      def request_headers
        headers = {}
      end

    end

  end
end
