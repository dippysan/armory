require 'memoizable'
require 'armory/utils'
require 'armory/meta_methods'
require 'armory/enumerable'

module Armory
  module Data
    class Achievements < MetaMethods
      include Armory::Enumerable
      include Armory::Utils
      include Memoizable

      attr_reader :achievementsCompleted, :achievementsCompletedTimestamp, :criteria, 
                  :criteriaQuantity, :criteriaTimestamp, :criteriaCreated
      alias_method :achievements_completed, :achievementsCompleted
      alias_method :achievements_completed_timestamp, :achievementsCompletedTimestamp
      alias_method :criteria_quantity, :criteriaQuantity
      alias_method :criteria_timestamp, :criteriaTimestamp
      alias_method :criteria_created, :criteriaCreated

      # "achievements": {
      #      "achievementsCompleted": [9141, 9146, 9618],
      #      "achievementsCompletedTimestamp": [1416270000000, 1416231960000, 1413967140000],
      #      "criteria": [26706, 26801, 26867, 26870],
      #      "criteriaQuantity": [1, 12, 1, 1],
      #      "criteriaTimestamp": [1416313542000, 1415832272000, 1416313542000, 1416313542000],
      #      "criteriaCreated": [1416313542000, 0, 1416313542000, 1416313542000]
      #  },

      def achievements
        self
      end
      alias_method :completed, :achievements

      def achievement_criteria
        @criteria
      end


      def initialize(attrs = {})
        super

        @collection = achievement_array.collect do |data|
          Data::Achievement.new(data)
        end
        @criteria = criteria_array.collect do |data|
          Data::AchievementCriteria.new(data)
        end
      end

    private

      def achievement_array
        merge_to_array_of_hashes( 
                            [:id, :timestamp],
                            [ :achievementsCompleted, :achievementsCompletedTimestamp]
                                )
      end      

      def criteria_array
        merge_to_array_of_hashes(
                            [:id, :quantity, :timestamp, :created],
                            [:criteria, :criteriaQuantity, :criteriaTimestamp, :criteriaCreated]
                                )
      end      

      def merge_to_array_of_hashes (key_array, sym_array)
        # First make a copy of the sym arrays in attrs, so we can shift off them
        source = {}
        sym_array.each do |sym|
          source[sym] = @attrs[sym].dup
        end

        source.fetch(sym_array.first).dup.map do ||
          # :id, :completed_timestamp
          element_hash = {}
          key_array.zip(sym_array) do |key,sym| # :id, :achievementsCompleted
            element_hash[key] = source[sym].shift
          end
          element_hash
        end
      end

    end
  end
end

