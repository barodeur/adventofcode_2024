module ReportSafety
  module_function

  def safe?(report)
    cons = report.each_cons(2).to_a
    first_con_diff = cons[0][0] - cons[0][1]
    cons.all? { |a, b|
      ((a - b).abs <= 3) && \
        (first_con_diff * (a - b) > 0)
    }
  end
end
