
class SwizzlePrefixTestKlass
  include Swizzle

  def self.klass_method
    "klass_method"
  end

  def self.new_prefix_klass_method
    "new_prefix_klass_method"
  end

  def instance_method
    "instance_method"
  end

  def new_prefix_instance_method
    "new_prefix_instance_method"
  end
end
