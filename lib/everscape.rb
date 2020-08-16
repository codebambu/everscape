# frozen_string_literal: true

require_relative 'everscape/map'
require_relative 'everscape/parser'
require_relative 'everscape/oracle'
require_relative 'everscape/player'
require_relative 'everscape/display'

# main instance of the game.
class Everscape
  def initialize
    @display = Display.new
    @oracle = Oracle.new
    @parser = Parser.new
    @player = Player.new
    @parser.oracle = @oracle
    @oracle.player = @player

    @entities = [@player]

    cell_size = [7, 14]
    room_count = 14

    @map = Map.new(@display.lines, @display.columns, cell_size, room_count)
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
