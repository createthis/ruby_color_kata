class Ratio
  # a   c
  # - = -
  # b   d
  def self.solve_for_b a, c, d
    d.to_f*a.to_f/c.to_f
  end

  def self.solve_for_d a, b, c
    c.to_f*b.to_f/a.to_f
  end
end
