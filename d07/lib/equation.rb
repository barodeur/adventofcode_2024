class Equation < Struct.new(:test_value, :numbers)
  class << self
    def array_from_io(io)
      io.each_line.map(&method(:from_string))
    end

    def from_string(string)
      test_value_str, numbers_str = string.split(":")
      new(
        test_value_str.to_i,
        numbers_str.split.map(&:to_i)
      )
    end
  end

  def pp
    "#{test_value}: #{numbers.join(" ")}"
  end
end
