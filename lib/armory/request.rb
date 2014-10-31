require 'armory/rest/client'

module Armory
  class Request
    attr_accessor :client, :request_method, :path, :options
    alias_method :verb, :request_method

    def region=(newregion)
      @region = newregion.upcase
    end

    def region
      @region ||= "US"
    end

    def locale=(newlocale)
      @locale = newlocale
    end

    def locale
      @locale ||= "en_US"
    end





    # @param client [Armory::Client]
    # @param request_method [String, Symbol]
    # @param path [String]
    # @param options [Hash]
    # @return [Armory::Request]
    def initialize(client, request_method, path, options = {})
      @client = client
      @request_method = request_method.to_sym
      @path = include_region_in_path(path, options)
      @options = include_locale_in_options(options)
    end

    # @return [Hash]
    def perform
      @client.send(@request_method, @path, @options).body
    end

    # @param klass [Class]
    # @param request [Armory::Request]
    # @return [Object]
    def perform_with_object(klass)
      klass.new(region, perform)
    end

    # @param klass [Class]
    # @return [Array]
    def perform_with_objects(klass)
      perform.collect do |element|
        klass.new(region, element)
      end
    end

    private

      def include_region_in_path(path, options = {})
        self.region = options.delete(:region) || self.region
        ::URI::join(Armory::REST::Client::PROTOCOL+region+Armory::REST::Client::BATTLENET,path)
      end

      def include_locale_in_options(options = {})
        options.fetch(:locale) {|k| options[k] = locale }
        options
      end
  end
end
