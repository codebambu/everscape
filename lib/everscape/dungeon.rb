require_relative 'map'

class Dungeon < Map
  def initialize(lines, columns, cell_size, room_count)
    super(lines, columns)
    @cell_size = cell_size
    @room_count = room_count
    @horizontal_corridors_paths = []
    @vertical_corridors_paths = []
    @corridors_paths = []
    @floor = []

    create_dungeon
  end

  def create_dungeon
    create_cells
    create_rooms
    create_corridors_paths
    create_corridors
    clear_corridors_paths
    create_floor

    @rooms.each do |room|
      room.walls.each do |wall|
        @objects << wall
      end
    end

    @horizontal_corridors.each do |corridor|
      corridor.walls.each do |wall|
        @objects << wall
      end
    end

    @vertical_corridors.each do |corridor|
      corridor.walls.each do |wall|
        @objects << wall
      end
    end

    @floor.each do |floor|
      @objects << floor
    end
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

  def create_cells
    lines, columns = @cell_size

    cells = []

    @grid.each_with_index do |line, line_index|
      # check if the next tile for the line is "on the grid"
      next unless line_index % lines == 0

      line.each_with_index do |_column, column_index|
        # check if the next tile for the columns is "on the grid"
        next unless column_index % columns == 0

        # if cell is within boundry of map, create the cell
        if line_index + lines < @lines && column_index + columns < @columns
          cell = Cell.new(line_index, column_index, @cell_size)
          cells << cell
        end
      end
    end

    cells = cells.sample(@room_count)

    @cells = cells
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

    path if path_valid
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

    path if path_valid
  end

  def in_horizontal_corridors_paths(line, column)
    @horizontal_corridors_paths.each do |path|
      path.each do |position|
        return true if position[0] == line && position[1] == column
      end
    end

    false
  end

  def in_vertical_corridors_paths(line, column)
    @vertical_corridors_paths.each do |path|
      path.each do |position|
        return true if position[0] == line && position[1] == column
      end
    end

    false
  end

  def create_horizontal_corridors_paths
    all_paths = []

    @rooms.each do |room|
      east_walls = room.east_walls
      east_walls.pop
      room_paths = []

      east_walls.each do |wall|
        path = get_east_path(wall)

        room_paths << path if path
      end

      room_paths.shuffle!

      all_paths << room_paths.first if room_paths.length > 0
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

        room_paths << path if path
      end

      room_paths.shuffle!

      all_paths << room_paths.first if room_paths.length > 0
    end

    @vertical_corridors_paths = all_paths
  end

  def create_corridors_paths
    create_horizontal_corridors_paths
    create_vertical_corridors_paths
    @corridors_paths = @horizontal_corridors_paths + @vertical_corridors_paths
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

      (first_north_wall.line + 1..first_south_wall.line - 1).each do |line|
        (first_north_wall.column + 1..last_north_wall.column - 1).each do |column|
          floor = Floor.new(line, column)

          floors << floor
        end
      end
    end

    @corridors_paths.each do |path|
      path.each do |position|
        floor = Floor.new(position[0], position[1])
        floors << floor
      end
    end

    @floor = floors
  end

  def draw_floor
    @floor.each do |floor|
      set_tile(floor.line, floor.column, floor)
    end
  end
end
