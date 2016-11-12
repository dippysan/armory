require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'
require 'set'

module Armory
  module REST
    module Spell
      include Armory::REST::Utils
      include Armory::Utils

      # The item API provides detailed spell information.
      #
      # @return [Armory::Spell] Spell Information
      # @param spell_id [integer | Armory::Data::Spell]
      # @param options [Hash] A customizable set of options.
      #  - fields: the dataset to retrieve
      def spell(spell_id, options = {})
        options = options.dup
        perform_with_object(:get, URI.escape("/wow/spell/#{spell_id}"),
          options, Armory::Data::Spell)
      end

      def spell_json(spell_id, options = {})
        options = options.dup
        perform(:get, URI.escape("/wow/spell/#{spell_id}"),
          options)
      end

    end
  end
end
