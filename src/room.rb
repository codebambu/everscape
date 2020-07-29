require_relative 'wall'

class Room
  def initialize(line, column, size)
    @walls = create_walls(line, column, size)
  end

  def walls
    @walls
  end

  def create_walls(line, column, size)
    lines, columns = size

    walls = []

    # west walls
    for i in 1..lines
      wall = Wall.new(line + i, column)
      walls << wall
    end

    # east walls
    for i in 1..lines
      wall = Wall.new(line + i, column + columns)
      walls << wall
    end

    # north walls
    for i in 1..columns
      wall = Wall.new(line, column + i)
      walls << wall
    end

    # south walls
    for i in 1..columns
      wall = Wall.new(line + lines, column + i)
      walls << wall
    end

    return walls
  end
end
