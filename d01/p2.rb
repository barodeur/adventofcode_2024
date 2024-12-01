require_relative "lib/read_lists"

l1, l2 = ReadLists.read($stdin)

l2_tally = l2.tally

puts l1.sum { _1 * l2_tally.fetch(_1, 0) }
