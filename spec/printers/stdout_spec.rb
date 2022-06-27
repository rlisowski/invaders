# frozen_string_literal: true

require "spec_helper"

RSpec.describe Invaders::Printers::StdOut do
  subject { described_class.new({ radar_image: radar_image, windows: windows, format: format }).call }
  let(:radar_image) do
    Invaders::RadarImage.new(<<~IMAGE)
      ---------
      ---------
      ---------
      ---------
    IMAGE
  end
  let(:windows) do
    [
      {
        similarity: 1,
        ship: Invaders::Ship.new,
        window: Invaders::RadarImage::Window.new(width: 1, height: 1, line: 19, column: 2)
      }
    ]
  end

  context "list" do
    let(:format) { "list" }
    let(:expected_print) do
      <<~OUTPUT
        Similarity: 1
        Position: {:start=>{:line=>19, :column=>2}, :end=>{:line=>20, :column=>3}}
      OUTPUT
    end

    it "prints" do
      expect { subject }.to output(expected_print).to_stdout
    end
  end

  context "pretty" do
    let(:format) { "pretty" }
    let(:windows) do
      [
        {
          similarity: 1,
          ship: Invaders::KnownShips::Fighter.new,
          window: Invaders::RadarImage::Window.new(width: 1, height: 1, line: 19, column: 2)
        }
      ]
    end
    let(:expected_print) do
      <<~OUTPUT
        ---------
        ---------
        ---------
        ---------
      OUTPUT
    end

    it "prints" do
      expect { subject }.to output(expected_print).to_stdout
    end
  end

  context "full" do
    let(:format) { "full" }
    let(:windows) do
      [
        {
          similarity: 1,
          ship: Invaders::KnownShips::Fighter.new,
          window: Invaders::RadarImage::Window.new(width: 0, height: 0, line: 0, column: 1)
        },
        {
          similarity: 1,
          ship: Invaders::KnownShips::Seeker.new,
          window: Invaders::RadarImage::Window.new(width: 0, height: 0, line: 1, column: 3)
        },
        {
          similarity: 1,
          ship: Invaders::Ship.new,
          window: Invaders::RadarImage::Window.new(width: 0, height: 0, line: 3, column: 5)
        }
      ]
    end
    let(:expected_print) do
      <<~OUTPUT
        -\e[31m-\e[0m-------
        ---\e[35m-\e[0m-----
        ---------
        -----\e[37m-\e[0m---
        Similarity: 1
        Position: {:start=>{:line=>0, :column=>1}, :end=>{:line=>0, :column=>1}}
        Similarity: 1
        Position: {:start=>{:line=>1, :column=>3}, :end=>{:line=>1, :column=>3}}
        Similarity: 1
        Position: {:start=>{:line=>3, :column=>5}, :end=>{:line=>3, :column=>5}}
      OUTPUT
    end

    it "prints" do
      expect { subject }.to output(expected_print).to_stdout
    end
  end
end
