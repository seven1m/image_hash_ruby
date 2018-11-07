require 'image_hash/version'
require 'mini_magick'

class ImageHash
  def initialize(path)
    @path = path
  end

  def binary_hash
    binary.join
  end

  def hash
    self.class.binary_to_hex(binary_hash)
  end

  def binary
    scale_down
    desaturate
    pixels.map { |v| v > average_value ? 1 : 0 }
  end

  class << self
    def hex_to_binary(hex)
      nums = hex.each_char.each_slice(2)
      bin_values = nums.map { |s| s.join.to_i(16).to_s(2).rjust(8, '0') }
      bin_values.join
    end

    def binary_to_hex(binary)
      bits = binary.each_char.map(&:to_i).each_slice(8)
      hex_values = bits.map { |s| s.join.to_i(2).to_s(16).rjust(2, '0') }
      hex_values.join
    end

    def binary_distance(s1, s2)
      diffs = s1.each_char.zip(s2.each_char).map do |c1, c2|
        c1 == c2 ? 0 : 1
      end
      diffs.inject(&:+)
    end

    def distance(s1, s2)
      binary_distance(hex_to_binary(s1), hex_to_binary(s2))
    end
  end

  private

  def scale_down
    image.resize('8x8!')
  end

  def desaturate
    image.format('jpg', 0, colorspace: 'Gray')
  end

  def image
    @image ||= MiniMagick::Image.open(@path)
  end

  def pixels
    @pixels ||= image.get_pixels.flat_map do |row|
      row.map { |r, g, b| rgb_to_value(r, g, b) }
    end
  end

  def average_value
    @average_value ||= pixels.inject(&:+) / pixels.size
  end

  def rgb_to_value(r, g, b)
    r /= 255.0
    g /= 255.0
    b /= 255.0
    max = [r, g, b].max
    min = [r, g, b].min
    (max + min) / 2.0
  end
end
