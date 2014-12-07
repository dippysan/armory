require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'

module Armory
  module REST
    module TalentData
      include Armory::REST::Utils
      include Armory::Utils

      # The talents data API provides a list of talents, specs and glyphs for each class.
      #
      # @return [Array of Armory::Data::ToonClass] Character Information
      # @param options [Hash] A customizable set of options.
      def talent_data(options = {})
        options = options.dup
        #perform_with_objects(:get, '/wow/data/talents', options, Armory::Data::ToonClass)
        talent_data = new_request(:get, '/wow/data/talents', options).perform
        talent_array = map_class_names_into_data_as_id(talent_data)
        talent_array.collect do |element|
          Armory::Data::ToonClass.new(element)
        end
      end

      private

      def map_class_names_into_data_as_id(hsh)
         hsh.map {|k,v| v[:id]=k.to_s.to_i; v}
      end

    end
  end
end
