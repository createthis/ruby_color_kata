require_relative 'color_input'

class Color
  attr_accessor :converter

  def initialize input
    input = ColorInput.new input
    input_a = input.to_a
    self.converter = input.rgb? ? Converter.new(rgb: input_a) : Converter.new(cmyk: input_a)
  end

  def real_cmyk_values
    return self.converter.cmyk unless self.converter.cmyk.empty?
    self.converter.to_cmyk
  end

  def cmyk_values params={}
    radix = Radix.new(params[:radix])
    real_cmyk_values.map {|v| radix.from_cmyk(v)}
  end

  def real_rgb_values
    return self.converter.rgb unless self.converter.rgb.empty?
    self.converter.to_rgb
  end

  def rgb_values params={}
    radix = Radix.new(params[:radix])
    real_rgb_values.map {|v| radix.from_rgb(v)}
  end

  def ==(other_object)
    rgb_values == other_object.rgb_values
  end
end
