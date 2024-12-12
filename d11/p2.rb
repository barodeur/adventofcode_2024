require_relative "lib/stones_counter"

pp StonesCounter.new.count($stdin.read.split, 75)
