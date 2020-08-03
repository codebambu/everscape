require_relative 'wall'

class Room
  def initialize(line, column, size)
    @walls = create_walls(line, column, size)

    @north_walls
    @south_walls
    @east_walls
    @west_walls
  end

  def walls
    @walls
  end

  def north_walls
    @north_walls
  end

  def south_walls
    @south_walls
  end

  def east_walls
    @east_walls
  end

  def west_walls
    @west_walls
  end

  def create_walls(line, column, size)
    lines, columns = size

    # walls = []

    north_walls = []
    south_walls = []
    east_walls = []
    west_walls = []

    # west walls
    for i in 1..lines
      wall = Wall.new(line + i, column)
      # walls << wall
      west_walls << wall
    end

    # east walls
    for i in 1..lines
      wall = Wall.new(line + i, column + columns)
      # walls << wall
      east_walls << wall
    end

    # north walls
    for i in 1..columns + 1
      wall = Wall.new(line, (column + i) - 1)
      # walls << wall
      north_walls << wall
    end

    # south walls
    for i in 1..columns
      wall = Wall.new(line + lines, column + i)
      # walls << wall
      south_walls << wall
    end

    @north_walls = north_walls
    @south_walls = south_walls
    @east_walls = east_walls
    @west_walls = west_walls

    walls = @north_walls + @south_walls + @east_walls + @west_walls

    return walls
  end
end
