# frozen_string_literal: true

module Invaders
  class KnownShips
    class Fighter < Ship
      def initialize
        @shape = <<~SHAPE
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

      def color_code
        31
      end
    end
  end
end
