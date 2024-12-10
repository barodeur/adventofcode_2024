require_relative "./lib/map"

map = Map.from_io($stdin)
puts map
  .each_same_frequency_position_permutations
  .each_with_object(Set.new) { |((x1, y1), (x2, y2)), set|
    pos = [x2 + (x2 - x1), y2 + (y2 - y1)]
    next unless map.position_within_bounds?(pos)

    set.add(pos)
  }
  .size
