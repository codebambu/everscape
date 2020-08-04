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

    size = [7, 14]
    room_count = 14

    @map = Map.new(@display.lines, @display.columns, size, room_count)
    @map.add_object(@player)
  end

  def start
    loop do
      @map.update_grid
      @display.draw(@map.grid)
      input = @parser.input
      @parser.parse(input)
    end
  end
end
