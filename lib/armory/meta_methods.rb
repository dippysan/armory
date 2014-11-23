require 'memoizable'
require 'armory/utils'

module Armory

  # Key to include in included object of master object
  class IncludeKey
    attr_reader :symbol
    def initialize(symbol, to_alias = symbol)
      @symbol = symbol
      @alias = to_alias
    end

    def to_alias
      @alias || @symbol
    end
  end

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


      # Define object methods from attribute#s
      #
      # @param klass [Symbol]
      # @param key1 [Symbol]
      # @param key2 [Symbol]
      def object_attr_reader(klass, key1, **args)
        define_attribute_method(key1, klass, args)
        define_predicate_method(key1, args)
      end

      # @param klass [Symbol]
      # @param key1 [Symbol], or [Array]
      # @param method_alias [Symbol] - alias
      # @param extra_key [Symbol] - down an extra level. IE progression: { raids: [...] }
      def object_attr_reader_as_array(klass, key1, *attrs)
        define_attribute_array_method(key1, klass, *attrs)
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

      #
      # Dr aynamically define a method #fo
      # @param key1 [ URISymbol]
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
            nil
          else
            if klass.nil?
              @attrs[key1]
            else
              extra_attrs = add_target_alias_if_requested(target_alias,@attrs[key1])
              target_params = add_wanted_keys_to_attrs(extra_attrs, include_keys)
              target_params = add_region_if_needed(klass, target_params)

              const_get_deep("Armory::#{klass}").new(*target_params)
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
      # @param extra_key [Symbol] - down an extra level. IE progression: { raids: [...] }
      def define_attribute_array_method(key1, klass, method_alias: key1, extra_key: nil)
        define_method(method_alias) do ||
          target = extra_key.nil? ? @attrs[key1] : @attrs[key1][extra_key]
          if target.nil? 
            nil
          else
            list_of_objects(const_get_deep("Armory::#{klass}"),key1, target)
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

    def add_target_alias_if_requested(target_alias,extra_attrs)
      target_alias.nil? ? extra_attrs : {target_alias => extra_attrs}
    end

    def add_region_if_needed(klass, target_params)
      if defined? @region and const_get_deep("Armory::#{klass}").stores_region?
        [@region, target_params]
      else
        [target_params]
      end
    end


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

    def add_wanted_keys_to_attrs(target, include_keys)
      return target if include_keys.nil?

      case target
        when Hash
          target = target.dup
          Array(include_keys).each do |key|
            # target[:itemId]  = @attrs[:itemId] or
            # target[:item_id] = @attrs[:itemId]
            target[key.to_alias] = @attrs[key.symbol]
          end
          target
        when Array
          # Add keys to every element of array
          target.dup.map {|h| add_wanted_keys_to_attrs(h,include_keys)}
        else
          raise "Can't merge keys into unknown type #{target.class}"
      end

    end
      
    def list_of_objects(klass, key, target_array)
      send_region = klass.stores_region?
      # use factory generator if object supports it
      creation_method = klass.respond_to?(:create)? :create : :new
      target_array.collect do |item|
        send_region ? klass.send(creation_method, region, item) : klass.send(creation_method, item)
      end
    end
  end
end
