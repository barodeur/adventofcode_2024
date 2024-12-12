require_relative "lib/memory"

memory = Memory.from_io($stdin)

last_file_end_cursor = memory.size - 1

while true
  last_file_end_cursor -= 1 until memory[last_file_end_cursor]
  break if last_file_end_cursor < 0
  last_file_id = memory[last_file_end_cursor]
  last_file_start_cursor = last_file_end_cursor
  last_file_start_cursor -= 1 while memory[last_file_start_cursor] == last_file_id
  last_file_start_cursor += 1

  last_file_size = last_file_end_cursor - last_file_start_cursor + 1

  free_start_cursor = 0
  while true
    free_start_cursor += 1 while memory[free_start_cursor]
    free_end_cursor = free_start_cursor
    free_end_cursor += 1 until memory[free_end_cursor] || free_end_cursor >= memory.size
    free_end_cursor -= 1
    free_size = free_end_cursor - free_start_cursor + 1

    if free_end_cursor >= last_file_start_cursor
      last_file_end_cursor = last_file_start_cursor - 1
      break
    end

    if free_size >= last_file_size
      memory[free_start_cursor, last_file_size] = memory[last_file_start_cursor, last_file_size]
      memory[last_file_start_cursor, last_file_size] = [nil] * last_file_size
      break
    end

    free_start_cursor = free_end_cursor + 1
  end
end

puts memory.checksum
