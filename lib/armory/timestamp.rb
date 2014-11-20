require 'memoizable'

module Armory
  module Timestamp
    include Memoizable

    def timestamp
      convert_to_time(@attrs[:timestamp])
    end
    memoize :timestamp

  private
    def convert_to_time(seconds_times_thousand)
      Time.at(seconds_times_thousand/1000) unless seconds_times_thousand.nil?
    end

  end
end
