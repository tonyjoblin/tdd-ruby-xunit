require_relative './xunit'

class WasRun < TestCase
  attr_reader :log

  def initialize(name)
    super
    @log = ''
  end

  def set_up
    @log = 'set_up '
  end

  def test_method
    @log += 'test_method '
  end

  def broken_method
    @log += 'raise broken '
    raise 'broken'
  end

  def tear_down
    @log += 'tear_down '
  end
end

class TestResultTest < TestCase
  def test_errors
    test = WasRun.new('broken_method')
    result = test.run
    assert '1 run, 1 failed\nFailing tests\nbroken_method', result.summary
  end
end

class TestCaseTest < TestCase
  def test_template_method
    test = WasRun.new('test_method')
    assert '', test.log
    test.run
    assert 'set_up test_method tear_down ', test.log
  end

  def test_result
    test = WasRun.new('test_method')
    result = test.run
    assert '1 run, 0 failed', result.summary
  end

  def test_failed_result
    test = WasRun.new('broken_method')
    result = test.run
    assert_true result.summary.start_with? '1 run, 1 failed'
  end

  def test_tear_down_invoked_on_failure
    test = WasRun.new('broken_method')
    test.run
    assert 'set_up raise broken tear_down ', test.log
  end
end

class TestSuiteTest < TestCase
  def test_suite_test
    suite = TestSuite.new
    suite.add(WasRun.new('test_method'))
    suite.add(WasRun.new('broken_method'))
    result = suite.run
    assert_true result.summary.start_with? '2 run, 1 failed'
  end
end

suite = TestSuite.new
suite.add TestCaseTest.new('test_template_method')
suite.add TestCaseTest.new('test_result')
suite.add TestCaseTest.new('test_failed_result')
suite.add TestCaseTest.new('test_tear_down_invoked_on_failure')
suite.add TestSuiteTest.new('test_suite_test')
suite.add TestResultTest.new('test_errors')
pp suite.run.summary

# test = TestResultTest.new('test_errors')
# pp test.run.summary
