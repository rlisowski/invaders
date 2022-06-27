# frozen_string_literal: true

require "thor"

module Invaders
  # CLI interface for Invaders
  class CLI < Thor
    desc "detect PATH", "Detect invaders in radar file"
    option :threshold, type: :numeric, default: 0.8, aliases: [:t]
    option :format, type: :string, default: "full", enum: %w[pretty list full], aliases: [:f]
    def detect(path)
      Invaders::Detector.new(
        file_path: path,
        threshold: options[:threshold],
        output: Printers::StdOut,
        format: options[:format],
      ).call
    rescue Error => e
      warn e.message
    end
    default_task :detect
  end
end
