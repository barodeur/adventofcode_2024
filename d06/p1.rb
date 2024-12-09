require_relative "./lib/map"

map = Map.from_io($stdin)

positions = Set.new([map.guard.position.dup])
while true
  result = map.guard.forward!
  case result
  when :moved then positions << map.guard.position.dup
  when :wall then map.guard.turn_right!
  when :out_of_bounds then break
  end
end

puts positions.size
