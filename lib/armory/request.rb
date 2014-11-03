require 'armory/request_bare'

module Armory
  class Request < Armory::RequestBare

    PROTOCOL = 'https://'
    BATTLENET = '.api.battle.net'

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

    def initialize(client, request_method, path, options = {})
      super
      @path = include_region_in_path(path, options)
      @options = include_locale_in_options(options)
    end

    private

    def include_region_in_path(path, options = {})
      self.region = options.delete(:region) || self.region
      ::URI::join(PROTOCOL+region+BATTLENET,path)
    end

    def include_locale_in_options(options = {})
      options.fetch(:locale) {|k| options[k] = locale }
      options
    end
  end
end
