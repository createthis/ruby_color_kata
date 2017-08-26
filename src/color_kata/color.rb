require_relative 'color_input'

class Color
  attr_accessor :converter

  def initialize input
    input = ColorInput.new input
    input_a = input.to_a
    self.converter = input.rgb? ? Converter.new(rgb: input_a) : Converter.new(cmyk: input_a)
  end

  def cmyk_values
    return self.converter.cmyk unless self.converter.cmyk.empty?
    self.converter.to_cmyk
  end

  def rgb_values
    return self.converter.rgb unless self.converter.rgb.empty?
    self.converter.to_rgb
  end

  def ==(other_object)
    cmyk_values == other_object.cmyk_values
  end
end
