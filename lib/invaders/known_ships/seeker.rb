# frozen_string_literal: true

module Invaders
  class KnownShips
    class Seeker < Ship
      def initialize
        @shape = <<~SHAPE
          --o-----o--
          ---o---o---
          --ooooooo--
          -oo-ooo-oo-
          ooooooooooo
          o-ooooooo-o
          o-o-----o-o
          ---oo-oo---
        SHAPE
      end

      def color_code
        35
      end
    end
  end
end
