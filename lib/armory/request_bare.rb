# Bare request with no adornments (region or locale)

module Armory
  class RequestBare
    attr_accessor :client, :request_method, :path, :options, :last_status
    alias_method :verb, :request_method
    include Armory::Utils

    # @param client [Armory::Client]
    # @param request_method [String, Symbol]
    # @param path [String]
    # @param options [Hash]
    # @return [Armory::Request]
    def initialize(client, request_method, path, options = {})
      @client = client
      @request_method = request_method.to_sym
      @path = path
      @options = options
    end

    def region
      region_from_url = @path.match('//(..)\.') do |matched|
        matched[1]
      end
    end



    # @return [Hash]
    def perform
      @last_status = nil
      response = @client.send(@request_method, @path, @options)
      @last_status = response.status
      response.body
    end

    # @param klass [Class]
    # @param request [Armory::Request]
    # @return [Object]
    def perform_with_object(klass)
      if klass.send(:stores_region?)
        klass.new(region, perform)
      else
        klass.new(perform)
      end
    end

    # @param klass [Class]
    # @return [Array]
    def perform_with_objects(klass, initial_key = nil)
      send_region = klass.stores_region?
      (initial_key.nil? ? perform : perform.fetch(initial_key, [])).collect do |element|
        send_region ? klass.new(region, element) : klass.new(element)
      end
    end

  end
end
