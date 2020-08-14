# frozen_string_literal: true

require_relative 'cell'
require_relative 'room'
require_relative 'floor'
require_relative 'corridor'

class Map
  def initialize(lines, columns, cell_size, room_count)
    @lines = lines
    @columns = columns
    @cell_size = cell_size
    @room_count = room_count
    @grid = []
    @objects = []
    @horizontal_corridors_paths = []
    @vertical_corridors_paths = []
    @corridors_paths = []
    @floor = []

    create_dungeon
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

  def create_dungeon
    initialize_grid
    create_cells
    create_rooms
    create_corridors_paths
    create_corridors
    clear_corridors_paths
    create_floor
  end

  def clear_corridors_paths
    @vertical_corridors.each do |vertical_corridor|
      vertical_corridor.walls.each_with_index do |wall, index|
        if in_horizontal_corridors_paths(wall.line, wall.column)
          vertical_corridor.walls.delete_at(index)
          vertical_corridor.walls.delete_at(index)
        end
      end
    end

    @horizontal_corridors.each do |horizontal_corridor|
      horizontal_corridor.walls.each_with_index do |wall, index|
        if in_vertical_corridors_paths(wall.line, wall.column)
          horizontal_corridor.walls.delete_at(index)
          horizontal_corridor.walls.delete_at(index)
        end
      end
    end
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

  def create_cells
    lines, columns = @cell_size

    cells = []

    @grid.each_with_index do |line, line_index|
      # check if the next tile for the line is "on the grid"
      if line_index % lines == 0
        line.each_with_index do |column, column_index|
          # check if the next tile for the columns is "on the grid"
          if column_index % columns == 0
            # if cell is within boundry of map, create the cell
            if line_index + lines < @lines && column_index + columns < @columns
              cell = Cell.new(line_index, column_index, @cell_size)
              cells << cell
            end
          end
        end
      end
    end

    cells = cells.shuffle.last(@room_count)

    @cells = cells
  end

  def set_tile(line, column, tile)
    @grid[line][column] = tile
  end

  def draw_cells
    @cells.each do |cell|
      set_tile(cell.line1, cell.column1, '1') # top left corner
      set_tile(cell.line2, cell.column2, '2') # bottom right corner
      set_tile(cell.line1, cell.column2, '3') # top righ`:qwt corner
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

    @rooms = rooms

    draw_rooms
  end

  def draw_rooms
    @rooms.each do |room|
      room.walls.each do |wall|
        set_tile(wall.line, wall.column, wall)
      end
    end
  end

  def get_east_path(wall)
    path = []
    path_valid = false

    (wall.column..@columns - 2).each do |column|
      current_line = wall.line
      current_column = column + 1

      path << [current_line, current_column - 1]

      current_grid_position = @grid[current_line][current_column]
      next_grid_position = @grid[current_line][current_column + 1]

      if current_grid_position.class == Wall && next_grid_position.class == String
        path_valid = true
        path << [current_line, current_column]

        break
      elsif current_grid_position.class == Wall
        break
      end
    end

    if path_valid
      return path
    else
      return nil
    end
  end

  def get_south_path(wall)
    path = []
    path_valid = false

    (wall.line..@lines - 3).each do |line|
      current_line = line + 1
      current_column = wall.column

      path << [current_line - 1, current_column]

      current_grid_position = @grid[current_line][current_column]
      next_grid_position = @grid[current_line + 1][current_column]

      if current_grid_position.class == Wall && next_grid_position.class == String
        path_valid = true
        path << [current_line, current_column]

        break
      elsif current_grid_position.class == Wall
        break
      end
    end

    if path_valid
      return path
    else
      return nil
    end
  end

  def in_horizontal_corridors_paths(line, column)
    @horizontal_corridors_paths.each do |path|
      path.each do |position|
        if position[0] == line && position[1] == column
          return true
        end
      end
    end

    return false
  end

  def in_vertical_corridors_paths(line, column)
    @vertical_corridors_paths.each do |path|
      path.each do |position|
        if position[0] == line && position[1] == column
          return true
        end
      end
    end

    return false
  end

  def create_horizontal_corridors_paths
    all_paths = []

    @rooms.each do |room|
      east_walls = room.east_walls
      east_walls.pop
      room_paths = []

      east_walls.each do |wall|
        path = get_east_path(wall)

        if path
          room_paths << path
        end
      end

      room_paths.shuffle!

      if room_paths.length > 0
        all_paths << room_paths.first
      end
    end

    @horizontal_corridors_paths = all_paths
  end

  def create_vertical_corridors_paths
    all_paths = []

    @rooms.each do |room|
      south_walls = room.south_walls
      south_walls.pop
      room_paths = []

      south_walls.each do |wall|
        path = get_south_path(wall)

        if path
          room_paths << path
        end
      end

      room_paths.shuffle!

      if room_paths.length > 0
        all_paths << room_paths.first
      end
    end

    @vertical_corridors_paths = all_paths
  end

  def create_corridors_paths
    create_horizontal_corridors_paths
    create_vertical_corridors_paths
    @corridors_paths = @horizontal_corridors_paths + @vertical_corridors_paths
  end

  def draw_corridors_paths
    @corridors_paths.each do |path|
      path.each do |position|
        set_tile(position[0], position[1], Floor.new(position[0], position[1]))
      end
    end
  end

  def create_horizontal_corridors
    horizontal_corridors = []

    @horizontal_corridors_paths.each do |path|
      corridor = Corridor.new('horizontal', path)

      horizontal_corridors << corridor
    end

    @horizontal_corridors = horizontal_corridors
  end

  def create_vertical_corridors
    vertical_corridors = []

    @vertical_corridors_paths.each do |path|
      corridor = Corridor.new('vertical', path)

      vertical_corridors << corridor
    end

    @vertical_corridors = vertical_corridors
  end

  def create_corridors
    create_horizontal_corridors
    create_vertical_corridors
  end

  def draw_corridors
    @horizontal_corridors.each do |corridor|
      corridor.walls.each do |wall|
        set_tile(wall.line, wall.column, wall)
      end
    end

    @vertical_corridors.each do |corridor|
      corridor.walls.each do |wall|
        set_tile(wall.line, wall.column, wall)
      end
    end
  end

  def create_floor
    floors = []

    @rooms.each do |room|
      first_north_wall = room.north_walls.first
      last_north_wall = room.north_walls.last

      first_south_wall = room.south_walls.first

      (first_north_wall.line..first_south_wall.line).each do |line|
        (first_north_wall.column..last_north_wall.column).each do |column|
          floor = Floor.new(line, column)

          floors << floor
        end
      end
    end

    @floor = floors
  end

  def draw_floor
    @floor.each do |floor|
      set_tile(floor.line, floor.column, floor)
    end
  end

  def update_grid
    @grid = initialize_grid

    # all draw methods here
    draw_floor
    draw_rooms
    draw_corridors_paths
    draw_corridors

    @objects.each do |object|
      set_tile(object.line, object.column, object)
    end
  end
end
