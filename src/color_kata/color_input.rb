require_relative 'radix'

class ColorInput
  attr_accessor :input, :radix

  def initialize input
    self.input = input
  end

  def includes? b
    self.input.any? {|k,v| b.include? k}
  end
  
  def valid?
    raise ArgumentError unless self.input.class == Hash

    cmyk = [:c, :m, :y, :k]
    rgb = [:r, :g, :b]
    raise ArgumentError if includes?(rgb) && includes?(cmyk)

    self.radix = Radix.new(self.input[:radix])

    self.input.values.each do |element|
      if self.input[:c]
        raise ArgumentError if element > self.radix.cmyk
      else
        raise ArgumentError if element > self.radix.rgb
      end
    end
  end

  def cmyk?
    valid?
    return true if self.input[:c]
    false
  end

  def rgb?
    !cmyk?
  end

  def to_a
    return [
      radix.to_cmyk(self.input[:c]),
      radix.to_cmyk(self.input[:m]),
      radix.to_cmyk(self.input[:y]),
      radix.to_cmyk(self.input[:k])
    ] if cmyk?
    [
      radix.to_rgb(self.input[:r]),
      radix.to_rgb(self.input[:g]),
      radix.to_rgb(self.input[:b])
    ]
  end
end
