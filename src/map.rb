# frozen_string_literal: true

# The world contained in a grid.
class Map
  def initialize(lines, columns)
    @lines = lines
    @columns = columns
    @grid = initialize_grid(@lines, @columns)
    @objects = []
  end

  def line
    @line
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

  def add_room(cell)
    # cell is array of coordinates [[line, column], ...]
    # TODO: implement feature to add a room onto the map.
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
              cell = create_cell(line_index, column_index, cell_size)
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

  def create_cell(line, column, cell_size)
    top_left = [line, column]
    top_right = [line, column + cell_size]
    bottom_left = [line + cell_size, column]
    bottom_right = [line + cell_size, column + cell_size]
    
    return {
      'top_left' => top_left,
      'top_right' => top_right,
      'bottom_left' => bottom_left,
      'bottom_right' => bottom_right
    }
  end

  def draw_cells(cells)
    cells.each do |cell|
      cell.each do |key, value|
        set_tile(value[0], value[1], 'x')
      end
    end
  end

  def update_grid
    @grid = initialize_grid(@lines, @columns)
    cells = create_cells(10)
    draw_cells(cells)
    @objects.each do |object|
      @grid[object.line][object.column] = object
    end
  end

  def add_object(object)
    @objects << object
    update_grid
  end
end
