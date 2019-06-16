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
