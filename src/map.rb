# frozen_string_literal: true

require_relative 'cell'
require_relative 'room'

# The world contained in a grid.
class Map
  def initialize(lines, columns)
    @lines = lines
    @columns = columns
    @grid = initialize_grid(@lines, @columns)
    @objects = []
    @cells = create_cells(11).shuffle.last(7)
    @rooms = create_rooms
  end

  def lines
    @lines
  end

  def columns
    @columns
  end

  def grid
    @grid
  end

  def objects
    @objets
  end
  
  def objects=(objects)
    @objects = objects
  end

  def initialize_grid(lines, columns)
    grid = []

    (1..lines).each do |i|
      grid << []
      (1..columns).each do |_j|
        grid[i - 1] << '.'
      end
    end

    grid
  end

  def create_cells(cell_size)
    cells = []
    
    @grid.each_with_index do |line, line_index|
      # check if the next tile for the line is "on the grid"
      if line_index % cell_size == 0
        line.each_with_index do |column, column_index|
          # check if the next tile for the columns is "on the grid"
          if column_index % cell_size == 0
            # if cell is within boundry of map, create the cell
            if line_index + cell_size < @lines and column_index + cell_size < @columns
              cell = Cell.new(line_index, column_index, cell_size)
              cells << cell
            end
          end
        end
      end
    end

    return cells
  end

  def set_tile(line, column, tile)
    @grid[line][column] = tile
  end

  def draw_cells
    @cells.each do |cell|
      set_tile(cell.line1, cell.column1, '1') # top left corner
      set_tile(cell.line2, cell.column2, '2') # bottom right corner
      set_tile(cell.line1, cell.column2, "3") # top right corner
      set_tile(cell.line2, cell.column1, '4') # bottom left corner
    end
  end

  def create_rooms
    rooms = []

    @cells.each do |cell|
      room = Room.new(cell.line1, cell.column1, rand(3..(cell.size - 1)))
    end

    return rooms
  end

  def draw_rooms
    # TODO
  end

  def update_grid
    @grid = initialize_grid(@lines, @columns)
    
    draw_cells
    draw_rooms
       
    @objects.each do |object|
      @grid[object.line][object.column] = object
    end
  end

  def add_object(object)
    @objects << object
    update_grid
  end
end
