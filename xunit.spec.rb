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

  def tear_down
    @log += 'tear_down '
  end
end

class TestCaseTest < TestCase
  def set_up
    @test = WasRun.new('test_method')
  end

  def test_template_method
    assert '', @test.log
    @test.run
    assert 'set_up test_method tear_down ', @test.log
  end
end

TestCaseTest.new('test_template_method').run
