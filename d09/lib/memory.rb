class Memory
  class << self
    def from_io(io)
      file_id = 0

      map = io
        .each_char
        .lazy
        .take_while { _1 != "\n" }
        .map(&:to_i)
        .each_with_index
        .each_with_object([]) do |(size, i), m|
          if i.even?
            size.times { m << file_id }
            file_id += 1
          else
            size.times { m << nil }
          end
        end

      new(map)
    end
  end

  def initialize(map)
    @map = map
  end

  def [](...) = @map.[](...)
  def []=(...); @map.[]=(...) end
  def size = @map.size

  def to_s
    @map.map {  _1 ? _1.to_s : "." }.join
  end

  def checksum
    @map.each_with_index.sum { |x, i| x ? x * i : 0 }
  end

end
