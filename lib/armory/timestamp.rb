require 'memoizable'

module Armory
  module Timestamp
    include Memoizable

    def timestamp
      convert_to_time(@attrs[:timestamp])
    end
    memoize :timestamp

    def seconds
      @attrs[:timestamp]
    end
    memoize :seconds

  private
    def convert_to_time(seconds_times_thousand)
      return nil if seconds_times_thousand==0
      Time.at(seconds_times_thousand/1000) unless seconds_times_thousand.nil?
    end

  end
end
