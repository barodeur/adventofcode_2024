require_relative "./guard"

class Map
  class << self
    def from_io(io)
      grid = io.each_line.map { _1.strip.chars }.to_a
      map = new(grid)
      map.guard = Guard.new(map)
      map.guard.position, map.guard.direction = map.grid.each_with_index.map { |row, y|
        row.each_with_index.map { |cell, x|
          [[x, y], Guard::DIRECTION_BY_SIGN[cell]] if Guard::DIRECTION_BY_SIGN.key?(cell)
        }.find(&:itself)
      }.find(&:itself)

      grid[map.guard.position[1]][map.guard.position[0]] = "."
      map
    end
  end

  attr_accessor :grid, :guard

  def initialize(grid)
    @grid = grid
  end

  def width = grid.first.size
  def height = grid.size

  def deep_dup
    map = self.class.new(grid.map(&:dup))
    map.guard = guard.deep_dup(map)
    map
  end
end
