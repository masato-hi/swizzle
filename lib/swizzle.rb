require "swizzle/version"

module Swizzle
  module ClassMethods
    DEFAULT_SWIZZLE_PREFIX = "swizzle_".freeze

    def swizzle_prefix=(prefix)
      @swizzle_prefix = prefix
    end

    def swizzle_prefix
      @swizzle_prefix ||= DEFAULT_SWIZZLE_PREFIX
    end

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
      regexp = Regexp.new("\\A#{swizzle_prefix}")

      @swizzled_class_methods    ||= {}
      @swizzled_instance_methods ||= {}

      # class methods
      swizzle_method_names = methods.select do |method_name|
        method_name =~ regexp
      end
      swizzle_method_names.each do |swizzle_method_name|
        method_name = swizzle_method_name.to_s.sub(regexp, "").to_sym
        next if @swizzled_class_methods.keys.include?(method_name)

        swizzle_method = method(swizzle_method_name)
        if singleton_class.method_defined?(method_name)
          singleton_class.send(:remove_method, method_name)
          singleton_class.send(:define_method, method_name, swizzle_method)
          @swizzled_class_methods[method_name] = swizzle_method_name
        end
      end

      # instance methods
      swizzle_instance_method_names = instance_methods.select do |instance_method_name|
        instance_method_name =~ regexp
      end
      swizzle_instance_method_names.each do |swizzle_instance_method_name|
        instance_method_name = swizzle_instance_method_name.to_s.sub(regexp, "").to_sym
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

      @swizzled = true
    end
  end
  extend ClassMethods

  def self.included(klass)
    klass.extend ClassMethods
  end
end
