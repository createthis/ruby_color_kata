require_relative 'ratio'

class Radix
  attr_accessor :radix

  def initialize radix=nil
    self.radix = radix
  end

  def standard_cmyk
    1.0
  end

  def cmyk
    self.radix ? self.radix : standard_cmyk
  end

  def standard_rgb
    255
  end

  def rgb
    self.radix ? self.radix : standard_rgb
  end

  def to_cmyk v
    # default   radix
    # ------- = -----
    # b         v
    Ratio.solve_for_b standard_cmyk, cmyk, v
  end

  def from_cmyk v
    # default   radix
    # ------- = -----
    # v         d
    (Ratio.solve_for_d standard_cmyk, v, cmyk).round(6) # <--- I feel like the spec is wrong if I need this.
  end

  def to_rgb v
    # default   radix
    # ------- = -----
    # b         v
    Ratio.solve_for_b standard_rgb, rgb, v
  end

  def from_rgb v
    # default   radix
    # ------- = -----
    # v         d
    (Ratio.solve_for_d standard_rgb, v, rgb).round
  end
end
