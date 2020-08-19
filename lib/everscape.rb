require 'io/console'
require_relative 'everscape/map'
require_relative 'everscape/parser'
require_relative 'everscape/player'
require_relative 'everscape/display'

class Everscape
  def initialize
    @display = Display.new
    @parser = Parser.new
    @player = Player.new
    @parser.player = @player
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

      command = STDIN.getch
      
      @parser.parse(command)
    end
  end
end
