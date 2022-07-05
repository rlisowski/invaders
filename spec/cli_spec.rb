# frozen_string_literal: true

require "spec_helper"

class DummyError < Invaders::Error; end

RSpec.describe Invaders::CLI do
  let(:detector) { double }

  describe "#detect" do
    it "calls detector and pass path" do
      expect(detector).to receive(:call)
      expect(Invaders::Detector).to receive(:new).with({ file_path: "dummy.txt", threshold: 0.8, format: "full",
                                                         output: Invaders::Printers::StdOut }).and_return detector

      Invaders::CLI.start ["detect", "dummy.txt"]
    end

    it "prints error" do
      expect(detector).to receive(:call).and_raise DummyError, "Dummy error"
      expect(Invaders::Detector).to receive(:new).with({ file_path: "dummy.txt", threshold: 0.8, format: "full",
                                                         output: Invaders::Printers::StdOut }).and_return detector
      expect { Invaders::CLI.start ["detect", "dummy.txt"] }.to output("Dummy error\n").to_stderr
    end
  end
end
