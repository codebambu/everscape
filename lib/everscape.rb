require 'io/console'
require_relative 'everscape/parser'
require_relative 'everscape/player'
require_relative 'everscape/display'
require_relative 'everscape/dungeon'

class Everscape
  def initialize
    @display = Display.new
    @parser = Parser.new
    @player = Player.new
    @parser.player = @player
    @entities = [@player]

    cell_size = [7, 14]
    room_count = 14

    @dungeon = Dungeon.new(@display.lines, @display.columns, cell_size, room_count)
    @dungeon.add_object(@player)
    @player.map = @dungeon
    @player.set_starting_position
  end

  def start
    loop do
      @dungeon.update_grid
      @display.draw(@dungeon.grid)

      command = STDIN.getch

      @parser.parse(command)
    end
  end
end
