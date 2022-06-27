# frozen_string_literal: true

require "spec_helper"

RSpec.describe Invaders::RadarImage do
  subject { described_class.new(image) }

  let(:image) do
    <<~IMAGE
      1234
      5678
      9012
    IMAGE
  end

  it "calculates all windows" do
    expect(subject.windows(3, 2)).to eq(
      [[%w[1 2 3], %w[5 6 7]],
       [%w[2 3 4], %w[6 7 8]],
       [%w[3 4 o], %w[7 8 o]],
       [%w[5 6 7], %w[9 0 1]],
       [%w[6 7 8], %w[0 1 2]],
       [%w[7 8 o], %w[1 2 o]]]
    )
  end

  it "calculates all windows" do
    expect(subject.windows(2, 3).map(&:to_a)).to eq(
      [[%w[1 2], %w[5 6], %w[9 0]],
       [%w[2 3], %w[6 7], %w[0 1]],
       [%w[3 4], %w[7 8], %w[1 2]],
       [%w[5 6], %w[9 0], %w[o o]],
       [%w[6 7], %w[0 1], %w[o o]],
       [%w[7 8], %w[1 2], %w[o o]]]
    )
  end
end
