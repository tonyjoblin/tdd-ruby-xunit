require 'pp'

class WasRun
  attr_reader :was_run

  def initialize(name)
    @name = name
    @was_run = false
  end

  def test_method
    @was_run = true
  end

  def run
    send(@name)
  end
end

test = WasRun.new('test_method')
pp test.was_run
test.run
pp test.was_run
