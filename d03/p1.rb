pp $stdin
  .read
  .scan(/mul\((\d+),(\d+)\)/)
  .sum { |a, b| a.to_i * b.to_i }
