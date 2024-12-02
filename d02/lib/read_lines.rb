module ReadLines
  module_function

  def read(io)
    io
      .each_line
      .map { _1.split.map(&:to_i) }
  end
end
