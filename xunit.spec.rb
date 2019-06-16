require_relative './xunit'

class WasRun < TestCase
  attr_reader :was_run, :was_setup

  def initialize(name)
    super
    @was_run = false
    @was_setup = false
  end

  def setup
    @was_setup = true
  end

  def test_method
    @was_run = true
  end
end

class TestCaseTest < TestCase
  def setup
    @test = WasRun.new('test_method')
  end

  def test_running
    assert_false @test.was_run
    @test.run
    assert_true @test.was_run
  end

  def test_setup
    @test.run
    assert_true @test.was_setup
  end
end

TestCaseTest.new('test_setup').run
