# frozen_string_literal: true

module Invaders
  class RadarImage
    include Enumerable

    attr_reader :pixels
    attr_accessor :bordered_pixels

    BORDER_TOLERANCE = 0.6

    def initialize(image)
      @pixels = image.split("\n").map(&:chars)
      @bordered_pixels = @pixels.dup
    end

    def windows(window_width, window_height)
      windows = []
      each(window_width, window_height) do |window|
        windows << window
      end

      windows
    end

    def each(window_width, window_height, &block)
      wrap_pixels(window_width, window_height)

      lines = bordered_pixels.size - (window_height * BORDER_TOLERANCE)
      columns = bordered_pixels.first.size - (window_width * BORDER_TOLERANCE)

      0.upto(lines) do |line_number|
        0.upto(columns) do |col_number|
          block.call window(window_width, window_height, line_number, col_number)
        end
      end
    end

    private

    # TODO: handle left side as well
    def wrap_pixels(_window_width, window_height)
      line_length = bordered_pixels.first.size
      (window_height * 0.2).floor.times do
        bordered_pixels.unshift(Array.new(line_length, Ship::SHIP_CHAR))
        pixels.unshift(Array.new(line_length, ""))
      end
    end

    def window(window_width, window_height, line_number, col_number)
      window = Window.new(width: window_width, height: window_height, line: line_number, column: col_number)

      window_height.times do |window_line|
        window_width.times do |window_col|
          # if algorithm is reaching outside the radar image range we pretend there is a ship
          # help detect ships that are partially visible
          pixel = (bordered_pixels[line_number + window_line] || [])[col_number + window_col] || Ship::SHIP_CHAR
          window.set(window_line, window_col, pixel)
        end
      end

      window
    end
  end
end
