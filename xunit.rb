require 'pp'

class AssertionError < StandardError
end

class TestCase
  def initialize(name)
    @name = name
  end

  def run
    send(@name)
  end

  def assert(a, b)
    raise AssertionError, "#{a.inspect} != #{b.inspect}" unless a == b
  end
end

class WasRun < TestCase
  attr_reader :was_run

  def initialize(name)
    super
    @was_run = false
  end

  def test_method
    @was_run = true
  end
end

class TestCaseTest < TestCase
  def test_running
    test = WasRun.new('test_method')
    assert(false, test.was_run)
    test.run
    assert(true, test.was_run)
  end
end

TestCaseTest.new('test_running').run
