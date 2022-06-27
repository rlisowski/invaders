# frozen_string_literal: true

module Invaders
  class NotShipError < Error; end
  class WrongShipSizeError < Error; end
  class WrongShipShapeError < Error; end

  class Ship
    attr_reader :shape

    SHIP_CHAR = "o"

    def initialize(shape = "")
      @shape = shape
    end

    # Can be extracted to other class
    # returns value from 0.0. to 1.0 based on the number of similar ship characters
    def similarity(other_ship)
      validate_similarity(other_ship)

      # we can use different algorithm here and let user pick one
      same_chars = each_char.zip(other_ship.each_char).count { |a, b| a == SHIP_CHAR && b == SHIP_CHAR }
      (same_chars / ship_chars_count.to_f).round(2)
    end

    def each_char
      normalized_ship_shape.each_char
    end

    def dimensions
      [width, height]
    end

    def width
      @shape.split("\n").first.to_s.chars.size
    end

    def height
      @shape.split("\n").size
    end

    def valid?
      lines_sizes = @shape.split("\n").map(&:size)
      lines_sizes.uniq.size == 1
    end

    def color_code
      37
    end

    private

    def validate_similarity(other_ship)
      raise NotShipError unless other_ship.is_a?(Ship)
      raise WrongShipShapeError unless valid?
      raise WrongShipShapeError unless other_ship.valid?
      raise WrongShipSizeError unless dimensions == other_ship.dimensions
    end

    def ship_chars_count
      normalized_ship_shape.count(SHIP_CHAR)
    end

    def normalized_ship_shape
      shape.gsub("\n", "")
    end
  end
end
