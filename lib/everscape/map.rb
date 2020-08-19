require_relative 'cell'
require_relative 'room'
require_relative 'floor'
require_relative 'corridor'

class Map
  attr_reader :lines, :columns, :grid
  attr_accessor :objects

  def initialize(lines, columns)
    @lines = lines
    @columns = columns
    @grid = []
    @objects = []
    
    initialize_grid
  end
  
  def initialize_grid
    grid = []

    (1..@lines).each do |i|
      grid << []
      (1..@columns).each do |_j|
        grid[i - 1] << ' '
      end
    end

    @grid = grid
  end

  def add_object(object)
    @objects << object
    update_grid
  end

  def set_tile(line, column, tile)
    @grid[line][column] = tile
  end

  def update_grid
    @grid = initialize_grid

    @objects.each do |object|
      set_tile(object.line, object.column, object)
    end
  end
end
