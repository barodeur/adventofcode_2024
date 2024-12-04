require_relative "./position"

class Grid
  class << self
    def from_io(io)
      new(io.each_line.map { _1.delete_suffix("\n").chars })
    end
  end

  def initialize(matrix)
    @matrix = matrix
  end

  def width
    @matrix.first.size
  end

  def height
    @matrix.size
  end

  def each_position
    Enumerator.new do |yielder|
      @matrix.each_with_index do |row, x|
        row.each_with_index do |cell, y|
          yielder << Position.new(grid: self, x:, y:)
        end
      end
    end
  end

  def letter_at(pos)
    @matrix[pos.y][pos.x]
  end
end
