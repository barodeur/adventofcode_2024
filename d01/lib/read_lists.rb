module ReadLists
  module_function

  def read(io)
    io
      .each_line
      .map { |line| line.split.map(&:to_i) }
      .each_with_object([[], []]) do |(a, b), (l1, l2)|
        l1 << a
        l2 << b
      end
  end
end
