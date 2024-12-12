class Map
  class << self
    def from_io(io)
      new(io.each_line.map { _1.chomp.chars.map(&:to_i) }.to_a)
    end
  end

  def initialize(grid)
    @grid = grid
  end

  def width = @grid[0].size
  def height = @grid.size

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def top?(pos)
    self[pos] == 9
  end

  def in_bounds?(pos)
    x, y = pos
    x >= 0 && y >= 0 && x < width && y < height
  end

  def zero_positions
    @grid.each_with_index.flat_map { |row, y|
      row.each_with_index.select { |cell, x| cell == 0 }.map { |_, x| [x, y] }
    }
  end

  def reacheable_positions_from(position:)
    x, y = position
    [[0, 1], [1, 0], [0, -1], [-1, 0]].filter_map do |dx, dy|
      n_pos = [x + dx, y + dy]
      next unless in_bounds?(n_pos)
      next unless self[n_pos] == self[position] + 1

      n_pos
    end
  end
end
