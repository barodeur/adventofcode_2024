class Update
  class << self
    def from_line(line)
      pages = line.split(",").map(&:to_i).map(&Page.method(:new))
      new(pages)
    end
  end

  attr_reader :pages

  def initialize(pages)
    @pages = pages
  end

  def ==(other)
    @pages == other.pages
  end

  alias eql? ==

  def correct?
    self == sort
  end

  def incorrect?
    !correct?
  end

  def sort
    self.class.new(@pages.sort)
  end

  def middle_page
    @pages[@pages.size / 2]
  end
end
