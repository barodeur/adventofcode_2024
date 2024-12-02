require_relative "lib/read_lines"
require_relative "lib/report_safety"

puts ReadLines.read($stdin)
  .count { |report|
    # fully safe
    ReportSafety.safe?(report) || \
      # safe if first level is omited
      ReportSafety.safe?(report[1..]) || \
      # safe if one other non first level is omited
      [1, -1].any? { |sign|
        errors_count = 0
        last = nil
        report.each do |n|
          break if errors_count > 1

          if last
            unless sign * (n - last) > 0 && (n - last).abs <= 3
              errors_count += 1
              next
            end
          end

          last = n
        end 

        errors_count <= 1
      }
  }
