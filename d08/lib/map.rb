class Map
  class << self
    def from_io(io)
      new(io.each_line.map { _1.strip.chars }.to_a)
    end
  end

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def antena_positions_by_frequency
    grid
      .each_with_index
      .with_object(Hash.new { |h, frequency| h[frequency] = Set.new }) do |(row, y), hsh|
        row.each_with_index do |cell, x|
          next if cell == "."
          hsh[cell].add([x, y])
        end
      end
  end

  def each_same_frequency_position_permutations
    Enumerator.new do |yielder|
      antena_positions_by_frequency.values.each do |positions|
        positions.to_a.permutation(2).each do |pos1, pos2|
          yielder.yield(pos1, pos2)
        end
      end
    end
  end

  def position_within_bounds?(pos)
    x, y = pos
    x >= 0 && y >= 0 && x < grid.first.size && y < grid.size
  end
end
