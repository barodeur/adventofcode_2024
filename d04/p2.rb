require_relative "lib/grid"

def xmas?(pos)
  pos.letter == "A" &&
    (
      (
        # M S
        #  A
        # M S
        pos.north_east&.letter == "S" &&
          pos.south_east&.letter == "S" &&
          pos.south_west&.letter == "M" &&
          pos.north_west&.letter == "M"
      ) ||
      (
        # S M
        #  A
        # S M
        pos.north_east&.letter == "M" &&
          pos.south_east&.letter == "M" &&
          pos.south_west&.letter == "S" &&
          pos.north_west&.letter == "S"
      ) ||
      (
        # M M
        #  A
        # S S
        pos.north_east&.letter == "M" &&
          pos.south_east&.letter == "S" &&
          pos.south_west&.letter == "S" &&
          pos.north_west&.letter == "M"
      ) ||
      (
        # S S
        #  A
        # M M
        pos.north_east&.letter == "S" &&
          pos.south_east&.letter == "M" &&
          pos.south_west&.letter == "M" &&
          pos.north_west&.letter == "S"
      )
    )
end

puts Grid.from_io($stdin)
  .each_position
  .count(&method(:xmas?))
