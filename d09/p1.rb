require_relative "lib/memory"

memory = Memory.from_io($stdin)

free_cursor = 0
last_cursor = memory.size - 1

while true
  free_cursor += 1 while memory[free_cursor]

  break if free_cursor >= last_cursor

  last_cursor -= 1 while !memory[last_cursor]

  memory[free_cursor], memory[last_cursor] = memory[last_cursor], memory[free_cursor]
end

puts memory.checksum
