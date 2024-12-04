require_relative "lib/directions"
require_relative "lib/grid"

def xmas?(pos:, direction:)
  "XMAS".chars.each_with_index.all? do |letter, i|
    ipos = i.times.reduce(pos) { _1.send(direction) }
    break false unless ipos

    ipos.letter == letter
  end
end

puts Grid.from_io($stdin)
  .each_position
  .sum { |pos| DIRECTIONS.keys.count { xmas?(pos:, direction: _1) } }
