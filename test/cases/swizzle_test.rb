require "test_helper"

class SwizzleTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Swizzle::VERSION
  end

  def test_it_swizzle!
    assert_equal "klass_method", SwizzleTestKlass.klass_method
    assert_equal "instance_method", SwizzleTestKlass.new.instance_method
    SwizzleTestKlass.swizzle!
    assert_equal "swizzled_klass_method", SwizzleTestKlass.klass_method
    assert_equal "swizzled_instance_method", SwizzleTestKlass.new.instance_method
  end

  def test_it_swizzle_prefix
    assert_equal "klass_method", SwizzlePrefixTestKlass.klass_method
    assert_equal "instance_method", SwizzlePrefixTestKlass.new.instance_method
    SwizzlePrefixTestKlass.swizzle!
    assert_equal "new_prefix_klass_method", SwizzlePrefixTestKlass.klass_method
    assert_equal "new_prefix_instance_method", SwizzlePrefixTestKlass.new.instance_method
  end

  def test_it_swizzled?
    assert_equal false, SwizzledTestKlass.swizzled?
    SwizzledTestKlass.swizzle!
    assert_equal true, SwizzledTestKlass.swizzled?
  end

  def test_it_swizzled_class_methods
    expected = {}
    assert_equal expected, SwizzledClassMethodsTestKlass.swizzled_class_methods

    SwizzledClassMethodsTestKlass.swizzle!
    expected = { klass_method: :swizzle_klass_method }
    assert_equal expected, SwizzledClassMethodsTestKlass.swizzled_class_methods
  end

  def test_it_swizzled_instance_methods
    expected = {}
    assert_equal expected, SwizzledInstanceMethodsTestKlass.swizzled_instance_methods

    SwizzledInstanceMethodsTestKlass.swizzle!
    expected = { instance_method: :swizzle_instance_method }
    assert_equal expected, SwizzledInstanceMethodsTestKlass.swizzled_instance_methods
  end
end
