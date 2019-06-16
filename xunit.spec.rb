require_relative './xunit'

class WasRun < TestCase
  attr_reader :log

  def initialize(name)
    super
    @log = ''
  end

  def setup
    @log = 'setup '
  end

  def test_method
    @log += 'test_method '
  end
end

class TestCaseTest < TestCase
  def setup
    @test = WasRun.new('test_method')
  end

  def test_template_method
    assert '', @test.log
    @test.run
    assert 'setup test_method ', @test.log
  end
end

TestCaseTest.new('test_template_method').run
