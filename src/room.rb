require_relative 'wall'

class Room
  def initialize(line, column, size)
    @walls = create_walls(line, column, size)
  end

  def walls
    @walls
  end

  def create_walls(line, column, size)
    walls = []

    # draw top wall
    for i in 1..size
      wall = Wall.new(line, column + i)
      walls << wall
    end

    # draw left wall
    for i in 1..size
      # +1 here is to offset the left wall so all walls are aligned
      wall = Wall.new(line + i, column + 1)
      walls << wall
    end

    # draw bottom wall
    for i in 1..size
      wall = Wall.new(line + size, column + i)
      walls << wall
    end

    # draw right wall
    for i in 1..size
      wall = Wall.new(line + i, column + size)
      walls << wall
    end

    return walls
  end
end
