# Bare request with no adornments (region or locale)

module Armory
  class RequestBare
    attr_accessor :client, :request_method, :path, :options, :last_status
    alias_method :verb, :request_method

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
      klass.new(region, perform)
    end

    # @param klass [Class]
    # @return [Array]
    def perform_with_objects(klass)
      perform.collect do |element|
        klass.new(region, element)
      end
    end

  end
end
