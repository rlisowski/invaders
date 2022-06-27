# frozen_string_literal: true

module Invaders
  module Printers
    # Print found ships to STDOUT
    class StdOut
      attr_reader :radar_image, :windows, :format

      def initialize(radar_image:, windows:, format:)
        @radar_image = radar_image
        @windows = windows
        @format = format
      end

      def call
        case format
        when "pretty"
          pretty_print
        when "list"
          print_list
        when "full"
          pretty_print
          print_list
        end
      end

      private

      def pretty_print
        radar_image.pixels.each_with_index do |line, line_number|
          line.each_with_index do |pixel, col_number|
            window = windows.find { |record| record[:window].cover?(line_number, col_number) }
            print(window ? colorize(window[:ship].color_code, pixel) : pixel)
          end
          puts
        end
      end

      def colorize(color_code, text)
        "\e[#{color_code}m#{text}\e[0m"
      end

      def print_list
        windows.each do |window|
          puts "Similarity: #{window[:similarity]}"
          puts "Position: #{window[:window].position}"
        end
      end
    end
  end
end
