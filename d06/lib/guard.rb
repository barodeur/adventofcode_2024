class Guard
  DIRECTION_BY_SIGN = {
    ">" => :right,
    "<" => :left,
    "^" => :up,
    "v" => :down,
  }

  DIRECTIONS = %i[up right down left]
  DELTA_BY_DIRECTION = {
    right: [1, 0],
    left: [-1, 0],
    up: [0, -1],
    down: [0, 1],
  }

  attr_accessor :map, :position, :direction

  def initialize(map = nil)
    @map = map
  end

  def forward!
    dx, dy = DELTA_BY_DIRECTION[direction]
    x, y = position
    x += dx
    y += dy

    unless x >= 0 && x < map.width && y >= 0 && y < map.height
      return :out_of_bounds
    end

    # hit a wall
    return :wall if map.grid[y][x] == "#"

    position[0] = x
    position[1] = y

    :moved
  end

  def turn_right!
    self.direction = DIRECTIONS[(DIRECTIONS.index(direction) + 1) % DIRECTIONS.size]
  end

  def deep_dup(map = nil)
    guard = self.class.new(map)
    guard.position = position.dup
    guard.direction = direction
    guard
  end
end
