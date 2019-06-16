require 'pp'

class AssertionError < StandardError
end

class TestCase
  def initialize(name)
    @name = name
  end

  def set_up; end

  def tear_down; end

  def run
    set_up
    send(@name)
    tear_down
  end

  def assert(expected, actual)
    if actual != expected
      raise AssertionError, "#{actual.inspect} != #{expected.inspect}"
    end
  end

  def assert_true(value)
    assert(true, value)
  end

  def assert_false(value)
    assert(false, value)
  end
end
