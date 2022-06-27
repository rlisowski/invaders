# frozen_string_literal: true

require "spec_helper"

RSpec.describe Invaders::Ship do
  subject { described_class.new(shape) }

  let(:shape) { "" }

  describe "validation" do
    let(:shape) do
      <<~SHAPE
        --o--o--
        ---o-o--o---
        ----o---
      SHAPE
    end

    it "complains on weird shape" do
      expect(subject.valid?).to be_falsey
    end
  end

  describe "dimensions" do
    let(:shape) do
      <<~SHAPE
        --o--o--
        ----o---
      SHAPE
    end

    it "calculates width" do
      expect(subject.width).to eql(8)
    end

    it "calculates height" do
      expect(subject.height).to eql(2)
    end

    it "calculates height" do
      expect(subject.dimensions).to eql([8, 2])
    end
  end

  describe "similarity" do
    let(:shape) do
      <<~SHAPE
        --o--o--
        --o-----
      SHAPE
    end

    let(:other_shape) do
      <<~SHAPE
        --o--o--
        -----o--
      SHAPE
    end

    let(:other_ship) { described_class.new(other_shape) }

    it "returns correct similarity level" do
      expect(subject.similarity(other_ship)).to eq(0.67)
    end

    context "same shape" do
      let(:shape) do
        <<~SHAPE
          --o--o--
          --o-----
        SHAPE
      end

      let(:other_shape) do
        <<~SHAPE
          --o--o--
          --o-----
        SHAPE
      end

      let(:other_ship) { described_class.new(other_shape) }

      it "returns correct similarity level" do
        expect(subject.similarity(other_ship)).to eq(1.0)
      end
    end

    context "big same shape" do
      let(:shape) do
        <<~SHAPE
          ---oo---
          --oooo--
          -oooooo-
          oo-oo-oo
          oooooooo
          --o--o--
          -o-oo-o-
          o-o--o-o
        SHAPE
      end

      let(:other_shape) do
        <<~SHAPE
          ---oo---
          --oooo--
          -oooooo-
          oo-oo-oo
          oooooooo
          --o--o--
          -o-oo-o-
          o-o--o-o
        SHAPE
      end

      let(:other_ship) { described_class.new(other_shape) }

      it "returns correct similarity level" do
        expect(subject.similarity(other_ship)).to eq(1.0)
      end
    end

    context "big similar shape" do
      let(:shape) do
        <<~SHAPE
          ---oo---
          --oooo--
          -oooooo-
          oo-oo-oo
          oooooooo
          --o--o--
          -o-oo-o-
          o-o--o-o
        SHAPE
      end

      let(:other_shape) do
        <<~SHAPE
          ---oo---
          --ooooo-
          -oo-ooo-
          oo-o-ooo
          o-oooooo
          --o--o--
          oo-oo-o-
          --oooo-o
        SHAPE
      end

      let(:other_ship) { described_class.new(other_shape) }

      it "returns correct similarity level" do
        expect(subject.similarity(other_ship)).to eq(0.89)
      end
    end

    context "errors" do
      context "weird own shape" do
        let(:shape) do
          <<~SHAPE
            --o--o--
            ---o-o--o---
            ----o---
          SHAPE
        end

        let(:other_shape) do
          <<~SHAPE
            --o--o--
            -----o--
          SHAPE
        end

        let(:other_ship) { described_class.new(other_shape) }

        it "complains" do
          expect { subject.similarity(other_ship) }.to raise_error Invaders::WrongShipShapeError
        end
      end

      context "weird other shape" do
        let(:shape) do
          <<~SHAPE
            --o--o--
            -----o--
          SHAPE
        end

        let(:other_shape) do
          <<~SHAPE
            --o--o--
            ---o-o--o---
            ----o---
          SHAPE
        end

        let(:other_ship) { described_class.new(other_shape) }

        it "complains" do
          expect { subject.similarity(other_ship) }.to raise_error Invaders::WrongShipShapeError
        end
      end

      context "diffeent ships sizes" do
        let(:shape) do
          <<~SHAPE
            --o--o--
            -----o--
          SHAPE
        end

        let(:other_shape) do
          <<~SHAPE
            --o--o---
            ---o-o---
            ----o----
          SHAPE
        end

        let(:other_ship) { described_class.new(other_shape) }

        it "complains" do
          expect { subject.similarity(other_ship) }.to raise_error Invaders::WrongShipSizeError
        end
      end

      context "compares to unknown object type" do
        let(:shape) do
          <<~SHAPE
            --o--o--
            -----o--
          SHAPE
        end

        it "complains" do
          expect { subject.similarity(12) }.to raise_error Invaders::NotShipError
        end
      end
    end
  end
end
