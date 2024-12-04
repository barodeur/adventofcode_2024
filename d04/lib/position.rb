require_relative "./directions"

class Position
  attr_reader :grid, :x, :y

  def initialize(grid:, x:, y:)
    @grid = grid
    @x = x
    @y = y
  end

  DIRECTIONS.each do |name, (dx, dy)|
    define_method(name) do
      new_x, new_y = x + dx, y + dy
      return nil unless new_x.between?(0, grid.width - 1) && new_y.between?(0, grid.height - 1)

      self.class.new(grid: @grid, x: @x + dx, y: @y + dy)
    end
  end

  def letter
    grid.letter_at(self)
  end
end
