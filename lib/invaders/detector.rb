# frozen_string_literal: true

module Invaders
  class FileNotFoundError < Error; end
  class FileIsEmpty < Error; end

  class Detector
    attr_reader :file_path, :threshold, :output, :format

    DEFAULT_THRESHOLD = 0.8

    def initialize(file_path:, threshold:, output:, format:)
      @file_path = file_path
      @threshold = threshold || DEFAULT_THRESHOLD
      @output = output
      @format = format
    end

    def call
      validate_file

      image = RadarImage.new(File.read(file_path))
      windows = detect_ships(image)
      handle_output(image, windows)
    end

    private

    def validate_file
      raise FileNotFoundError, "File not found" unless File.exist?(file_path)
      raise FileIsEmpty, "File is empty" if File.zero?(file_path)
    end

    def detect_ships(image)
      windows = []
      KnownShips.new.each do |ship|
        image.each(ship.width, ship.height) do |window|
          similarity = ship.similarity(Ship.new(window.to_s))
          next unless similarity > threshold

          windows << { ship: ship, similarity: similarity, window: window }
        end
      end
      windows
    end

    def handle_output(image, windows)
      output.new(
        radar_image: image,
        windows: windows,
        format: format
      ).call
    end
  end
end
