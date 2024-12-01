require_relative "lib/read_lists"

l1, l2 = ReadLists.read($stdin)

l1.sort!
l2.sort!

puts l1.zip(l2).sum { |a, b| (a - b).abs }
