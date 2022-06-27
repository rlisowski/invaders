# frozen_string_literal: true

require_relative "invaders/version"

require_relative "invaders/error"
require_relative "invaders/ship"
require_relative "invaders/known_ships"
require_relative "invaders/radar_image_window"
require_relative "invaders/radar_image"
require_relative "invaders/printers/stdout"
require_relative "invaders/detector"

require_relative "invaders/cli"

# Detect invaders and survive
module Invaders
end
