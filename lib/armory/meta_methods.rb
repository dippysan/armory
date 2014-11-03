require 'memoizable'

module Armory
  class MetaMethods
    extend Forwardable
    include Memoizable
    include Armory::Utils

    def self.stores_region?
      false
    end

    # @return [Hash]
    attr_reader :attrs
    alias_method :to_h, :attrs
    alias_method :to_hash, :to_h


    class << self
      # Keep ruby's original accessible as we use it for region
      alias_method :ruby_attr_reader, :attr_reader

      # Define methods that retrieve the value from attributes
      #
      # @param attrs [Array, Symbol]
      def attr_reader(*attrs)
        attrs.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
        end
      end

      def predicate_attr_reader(*attrs)
        attrs.each do |attr|
          define_predicate_method(attr)
          deprecate_attribute_method(attr)
        end
      end

      # Define object methods from attributes
      #
      # @param klass [Symbol]
      # @param key1 [Symbol]
      # @param key2 [Symbol]
      def object_attr_reader(klass, key1, **args)
        define_attribute_method(key1, klass, args)
        define_predicate_method(key1, args)
      end

      # Define URI methods from attributes
      # Defines both uri and url versions (:display_uri also defines display_url)
      # @param attrs [Array, Symbol]
      def url_attr_reader(*attrs)
        attrs.each do |primary_key|
          define_uri_method(primary_key)
          define_predicate_method(primary_key)
        end
      end

      # Dynamically define a method for a URI
      #
      # @param key1 [Symbol]
      def define_uri_method(key1)
        define_method(key1) do ||
          Addressable::URI.parse(@attrs[key1]) unless @attrs[key1].nil?
        end
        memoize(key1)
      end

      # Dynamically define a method for an attribute
      #
      # @param key1 [Symbol], or [Array]
      # @param klass [Symbol]
      # @param method_alias [Symbol] - alias
      def define_attribute_method(key1, klass = nil, method_alias: key1, target_alias: key1)
        define_method(method_alias) do ||
          if @attrs[key1].nil? || @attrs[key1].respond_to?(:empty?) && @attrs[key1].empty?
            NullObject.new
          else
            if klass.nil?
              @attrs[key1]
            else
              if defined? @region and Armory.const_get(klass).stores_region?
                Armory.const_get(klass).new(@region, target_alias => @attrs[key1])
              else
                Armory.const_get(klass).new(@attrs[key1])
              end
            end
          end
        end
        memoize(method_alias)
      end

      # @param key [Symbol]
      def deprecate_attribute_method(key, method_alias = key)
        define_method(method_alias) do ||
          warn "#{Kernel.caller.first}: [DEPRECATION] ##{key} is deprecated. Use ##{key}? instead."
          @attrs[key]
        end
        memoize(method_alias)
      end

      # Dynamically define a predicate method for an attribute
      #
      # @param key1 [Symbol]
      # @param method_alias [Symbol]
      def define_predicate_method(key1, method_alias: key1, target_alias: key1)
        define_method(:"#{method_alias}?") do ||
          !@attrs[key1].nil? && @attrs[key1] != false && !(@attrs[key1].respond_to?(:empty?) && @attrs[key1].empty?)
        end
        memoize(:"#{method_alias}?")
      end

    end

    # Initializes a new object
    #
    # @param attrs [region:String, Hash]
    # @return [Armory::Base]
    def initialize(attrs = {})
      @attrs = attrs || {}
    end


  end
end
