# frozen_string_literal: true

require_relative 'cell'
require_relative 'room'

class Map
  def initialize(lines, columns, cell_size, room_count)
    @lines = lines
    @columns = columns
    @grid = initialize_grid(@lines, @columns)
    @objects = []
    @cells = create_cells(cell_size).shuffle.last(room_count)
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

  def create_cells(size)
    lines, columns = size

    cells = []

    @grid.each_with_index do |line, line_index|
      # check if the next tile for the line is "on the grid"
      if line_index % lines == 0
        line.each_with_index do |column, column_index|
          # check if the next tile for the columns is "on the grid"
          if column_index % columns == 0
            # if cell is within boundry of map, create the cell
            if line_index + lines < @lines and column_index + columns < @columns
              cell = Cell.new(line_index, column_index, size)
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
      set_tile(cell.line1, cell.column2, '3') # top right corner
      set_tile(cell.line2, cell.column1, '4') # bottom left corner
    end
  end

  def create_rooms
    rooms = []

    @cells.each do |cell|
      cell_lines, cell_columns = cell.size

      room_lines = rand(3..(cell_lines - 1))
      room_columns = rand(3..(cell_columns - 1))
      room_size = [room_lines, room_columns]
      
      room = Room.new(cell.line1, cell.column1, room_size)
      rooms << room
    end

    return rooms
  end

  def draw_rooms
    @rooms.each do |room|
      room.walls.each do |wall|
        set_tile(wall.line, wall.column, wall)
      end
    end
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
