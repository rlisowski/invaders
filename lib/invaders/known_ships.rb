# frozen_string_literal: true

require_relative "known_ships/fighter"
require_relative "known_ships/seeker"

module Invaders
  class KnownShips
    include Enumerable

    def initialize
      @known_ships = [Seeker.new, Fighter.new]
    end

    def each(&block)
      @known_ships.each do |ship|
        block.call ship
      end
    end
  end
end
