# frozen_string_literal: true

require "spec_helper"

RSpec.describe Invaders::Detector do
  subject do
    described_class.new(file_path: path, threshold: 0.8, format: "full", output: Invaders::Printers::StdOut).call
  end

  context "missing file" do
    let(:path) { "asd.log" }

    it "complains" do
      expect { subject }.to raise_error(Invaders::FileNotFoundError)
    end
  end

  context "empty file" do
    let(:tempfile) do
      Tempfile.new("csv").tap(&:close)
    end
    let(:path) { tempfile.path }

    after do
      tempfile.unlink
    end

    it "complains" do
      expect { subject }.to raise_error(Invaders::FileIsEmpty)
    end
  end

  context "file with ship" do
    let(:tempfile) do
      Tempfile.new("csv").tap do |f|
        f.write <<~SHIP
          ---oo---
          --oooo--
          -oooooo-
          oo-oo-oo
          oooooooo
          --o--o--
          -o-oo-o-
          o-o--o-o
        SHIP

        f.close
      end
    end
    let(:path) { tempfile.path }
    let(:dummy_printer) { double }

    after do
      tempfile.unlink
    end

    it "detects ship" do
      expect(dummy_printer).to receive(:call)
      expect(Invaders::Printers::StdOut).to receive(:new)
        .with(radar_image: kind_of(Invaders::RadarImage),
              windows: kind_of(Array),
              format: "full")
        .and_return dummy_printer
      subject
    end
  end
end
