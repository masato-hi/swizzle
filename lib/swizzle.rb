require "swizzle/version"

module Swizzle
  module ClassMethods
    DEFAULT_SWIZZLE_PREFIX = "swizzle_".freeze

    def swizzled_class_methods
      @swizzled_class_methods ||= {}
    end

    def swizzled_instance_methods
      @swizzled_instance_methods ||= {}
    end

    def swizzled?
      @swizzled ||= false
    end

    def swizzle!
      swizzle_class_methods!
      swizzle_instance_methods!

      @swizzled = true
    end

    private

    def swizzle_prefix(prefix = nil)
      @swizzle_prefix ||= DEFAULT_SWIZZLE_PREFIX
      @swizzle_prefix = prefix unless prefix.nil?
      @swizzle_prefix
    end

    def swizzle_prefix_regexp
      Regexp.new("\\A#{swizzle_prefix}")
    end

    def swizzle_class_methods!
      @swizzled_class_methods ||= {}

      swizzle_method_names = methods.select do |method_name|
        method_name =~ swizzle_prefix_regexp
      end

      swizzle_method_names.each do |swizzle_method_name|
        method_name = swizzle_method_name.to_s.sub(swizzle_prefix_regexp, "").to_sym
        next if @swizzled_class_methods.keys.include?(method_name)

        swizzle_method = method(swizzle_method_name)
        next unless singleton_class.method_defined?(method_name)
        singleton_class.send(:remove_method, method_name)
        singleton_class.send(:define_method, method_name, swizzle_method)
        @swizzled_class_methods[method_name] = swizzle_method_name
      end
    end

    def swizzle_instance_methods!
      @swizzled_instance_methods ||= {}

      swizzle_instance_method_names = instance_methods.select do |instance_method_name|
        instance_method_name =~ swizzle_prefix_regexp
      end

      swizzle_instance_method_names.each do |swizzle_instance_method_name|
        instance_method_name = swizzle_instance_method_name.to_s.sub(swizzle_prefix_regexp, "").to_sym
        next if @swizzled_instance_methods.keys.include?(instance_method_name)

        swizzle_instance_method = instance_method(swizzle_instance_method_name)
        class_eval do
          if method_defined?(instance_method_name)
            remove_method(instance_method_name)
            define_method(instance_method_name, swizzle_instance_method)
            @swizzled_instance_methods[instance_method_name] = swizzle_instance_method_name
          end
        end
      end
    end
  end
  extend ClassMethods

  def self.included(klass)
    klass.extend ClassMethods
  end
end
