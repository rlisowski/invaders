# frozen_string_literal: true

module Invaders
  class RadarImage
    class Window
      attr_accessor :window
      attr_reader :line, :column, :width, :height

      def initialize(width:, height:, line:, column:)
        @line = line
        @column = column
        @width = width
        @height = height
        @window = Array.new(height) { Array.new(width, "-") }
      end

      def set(line, col, value)
        window[line][col] = value
      end

      def ==(other)
        window == other.to_a
      end

      def to_a
        window
      end

      def to_s
        window.map(&:join).join("\n")
      end
      alias inspect to_s

      def position
        {
          start: {
            line: line,
            column: column
          },
          end: {
            line: line + height,
            column: column + width
          }
        }
      end

      def cover?(line, col)
        @line <= line &&
          @line + @height >= line &&
          @column <= col &&
          @column + @width >= col
      end
    end
  end
end
