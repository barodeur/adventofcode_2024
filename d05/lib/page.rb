require_relative "./page/comparator"

class Page
  class << self
    attr_accessor :comparator
  end

  attr_reader :n

  def initialize(n)
    @n = n
  end

  def ==(other)
    n == other.n
  end

  alias eql? ==

  def hash = n

  def inspect
    "Page(#{n})"
  end

  def <=>(other)
    self.class.comparator.compare(self, other)
  end
end
