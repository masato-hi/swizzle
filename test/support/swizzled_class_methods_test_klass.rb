# frozen_string_literal: true

class SwizzledClassMethodsTestKlass
  include Swizzle

  def self.klass_method
    "klass_method"
  end

  def self.swizzle_klass_method
    "swizzled_klass_method"
  end

  def instance_method
    "instance_method"
  end

  def swizzle_instance_method
    "swizzled_instance_method"
  end
end
