require 'minitest/autorun'

clas EasyTestingTest < Minitest::Test

# 1.)

  def test_value_odd?
    assert value.odd?, 'value is not odd'
  end

# 2.)

  def test_downcase
    value = "XYZ"
    assert_equal "xyz", value.downcase
  end

# 3.)

assert_nil value

# 4.)

assert_equal true, list.empty?

# 5.)

assert_equal true, list.include?('xyz')

# 6.)

assert_raises(NoExperienceError) { employee.hire }

# 7.)

assert_instance_of Numeric, value

# 8.)

assert_kind_of Numeric, value

# 9.)

assert_same list, list_process

# 10.)

refute_includes list, 'xyz'
