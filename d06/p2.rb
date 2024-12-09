require_relative "./lib/map"

original_map = Map.from_io($stdin)

test_map = original_map.deep_dup
positions = Set.new([test_map.guard.position.dup])
while true
  result = test_map.guard.forward!
  case result
  when :moved then positions << test_map.guard.position.dup
  when :wall then test_map.guard.turn_right!
  when :out_of_bounds then break
  end
end

puts positions.count { |position|
  map = original_map.deep_dup

  # put a wall at the position
  map.grid[position[1]][position[0]] = "#"

  history = Set.new([[map.guard.position.dup, map.guard.direction]])
  looped = false
  while true
    result = map.guard.forward!
    case result
    when :moved
      if history.include?([map.guard.position, map.guard.direction])
        looped = true
        break
      end
      history << [map.guard.position.dup, map.guard.direction]
    when :wall then map.guard.turn_right!
    when :out_of_bounds then break
    end
  end

  looped
}
