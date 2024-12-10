require_relative "./lib/map"

map = Map.from_io($stdin)
puts map
  .each_same_frequency_position_permutations
  .each_with_object(Set.new) { |((x1, y1), (x2, y2)), set|
    (0..)
      .lazy
      .map { |count| [x2 + count * (x2 - x1), y2 + count * (y2 - y1)] }
      .take_while { |pos| map.position_within_bounds?(pos) }
      .each { |pos| set.add(pos) }
  }
  .size
