require 'memoizable'
require 'armory/utils'

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

      def predicate_attr_reader_with_alias(meth, meth_alias)
        predicate_attr_reader(meth)
        define_predicate_method(meth, method_alias: meth_alias)
        deprecate_attribute_method(meth, meth_alias)
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

      def object_attr_reader_as_array(klass, key1)
        define_attribute_array_method(key1, klass)
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
      # @param target_alias [Symbol] - key for this item in the target class
      # @param include_keys [Symbol] - used in define_attribute_method not here
      def define_attribute_method(key1, klass = nil, method_alias: key1, target_alias: nil, include_keys: nil)
        define_method(method_alias) do ||
          if @attrs[key1].nil?
            NullObject.new
          else
            if klass.nil?
              @attrs[key1]
            else
              if defined? @region and const_get_deep("Armory::#{klass}").stores_region?
                target_alias ||= key1
                const_get_deep("Armory::#{klass}").new(@region, target_alias => @attrs[key1])
              else
                if target_alias.nil?
                  extra_attrs = add_wanted_keys_to_attrs(@attrs[key1], include_keys)
                  const_get_deep("Armory::#{klass}").new(extra_attrs)
                else
                  const_get_deep("Armory::#{klass}").new(target_alias => @attrs[key1])
                end
              end
            end
          end
        end
        memoize(method_alias)
      end

      # Dynamically define a method for an attribute which contains an array of objetcts
      #
      # @param key1 [Symbol], or [Array]
      # @param klass [Symbol]
      # @param method_alias [Symbol] - alias
      # @param target_alias [Symbol] - key for this item in the target class
      # @param include_keys [Symbol] - used in define_attribute_method not here
      def define_attribute_array_method(key1, klass, method_alias = key1)
        define_method(method_alias) do ||
          if @attrs[key1].nil? 
            NullObject.new
          else
            list_of_objects(const_get_deep("Armory::#{klass}"),key1)
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
      # @param method_alias [Symbol] - alternate name for this method
      # @param target_alias [Symbol] - used in define_attribute_method not here
      # @param include_keys [Symbol] - used in define_attribute_method not here
      def define_predicate_method(key1, method_alias: key1, target_alias: key1, include_keys: nil)
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

  private
    # deep version of const_get that handles :: like Armory::Character::Achievements
    def const_get_deep(str)
      raise "Can't call const_get_deep - #{str} is not defined" unless const_defined_deep? str
      str.split("::").inject(Object) {|x,y| x = x.const_get(y)}
    end
    def const_defined_deep?(str)
      str.split("::").inject(Object) {|x,y| x.const_defined?(y) ? x.const_get(y) : raise("#{y} not defined for #{str}") }
    end

    def slice hsh, keys
      hsh.select{|k| keys.member?(k)}
    end

    def add_wanted_keys_to_attrs(target, keys_to_add)
      return target if keys_to_add.nil?

      case target
        when Hash
          target.dup.merge(slice(@attrs, Array(keys_to_add)))
        when Array
          # Add keys to every element of array
          target.dup.map {|h| add_wanted_keys_to_attrs(h,keys_to_add)}
        else
          raise "Can't merge keys into unknown type #{target.class}"
      end

    end
      
    def list_of_objects(klass, key)
      send_region = klass.stores_region?
      # use factory generator if object supports it
      creation_method = klass.respond_to?(:create)? :create : :new
      @attrs.fetch(key.to_sym, {}).collect do |item|
        send_region ? klass.send(creation_method, region, item) : klass.send(creation_method, item)
      end
    end
  end
end
