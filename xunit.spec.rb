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
    assert '1 run, 1 failed', result.summary
  end

  def test_tear_down_invoked_on_failure
    test = WasRun.new('broken_method')
    result = test.run
    assert 'set_up raise broken tear_down ', result.summary
  end
end

result = TestCaseTest.new('test_failed_result').run
puts result.summary
