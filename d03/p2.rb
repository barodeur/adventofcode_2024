enabled = true

puts $stdin
  .read
  .scan(/(mul\((\d+),(\d+)\))|(do\(\))|(don\'t\(\))/)
  .sum { |_, a_str, b_str, do_str, don_t_str|
    enabled = true if do_str
    enabled = false if don_t_str

    next 0 if do_str || don_t_str
    next 0 unless enabled

    a_str.to_i * b_str.to_i
  }

