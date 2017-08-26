class ColorInput
  attr_accessor :input

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

    self.input.values.each do |element|
      if self.input[:c]
        raise ArgumentError if element > 1.0
      else
        raise ArgumentError if element > 255
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
    return [self.input[:c], self.input[:m], self.input[:y], self.input[:k]] if cmyk?
    [self.input[:r], self.input[:g], self.input[:b]]
  end
end
