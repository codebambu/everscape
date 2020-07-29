# frozen_string_literal: true

require_relative 'map'
require_relative 'parser'
require_relative 'oracle'
require_relative 'player'
require_relative 'display'

# Main instance of the game.
class Main
  def initialize
    @display = Display.new
    @oracle = Oracle.new
    @parser = Parser.new
    @player = Player.new
    @parser.oracle = @oracle
    @oracle.player = @player

    @entities = [@player]

    @map = Map.new(@display.lines, @display.columns, [7, 14], 14)

    @entities.each do |entity|
      @map.add_object(entity)
    end
  end

  def start
    loop do
      @map.objects = @entities
      @map.update_grid
      @display.draw(@map.grid)
      input = @parser.input
      @parser.parse(input)
    end
  end
end
