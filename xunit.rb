require 'pp'

class AssertionError < StandardError
end

class TestResult
  def initialize
    @run_count = 0
    @fail_count = 0
  end

  def test_started
    @run_count += 1
  end

  def test_failed
    @fail_count += 1
  end

  def summary
    "#{@run_count} run, #{@fail_count} failed"
  end
end

class TestCase
  def initialize(name)
    @name = name
  end

  def set_up; end

  def tear_down; end

  def run(result = TestResult.new)
    result.test_started
    set_up
    send(@name)
    result
  rescue StandardError
    result.test_failed
    result
  ensure
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

class TestSuite
  def initialize
    @tests = []
  end

  def add(test)
    @tests << test
  end

  def run
    result = TestResult.new
    @tests.each { |test| test.run(result) }
    result
  end
end
