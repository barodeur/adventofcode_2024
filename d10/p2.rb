require_relative "lib/map"

map = Map.from_io($stdin)

puts map.zero_positions.sum { |pos|
  paths = [[pos]]

  top_paths = Set.new

  until paths.empty?
    path = paths.shift
    pos = path.last

    if map.top?(pos)
      top_paths << path
      next
    end

    map.reacheable_positions_from(position: pos).each do |n_pos|
      paths << [*path, n_pos]
    end
  end

  top_paths.size
}
