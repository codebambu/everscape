require_relative 'wall'

class Room
  attr_reader :walls, :north_walls, :south_walls, :east_walls, :west_walls

  def initialize(line, column, size)
    @walls = create_walls(line, column, size)

    @north_walls
    @south_walls
    @east_walls
    @west_walls
  end

  def create_walls(line, column, size)
    lines, columns = size

    north_walls = []
    south_walls = []
    east_walls = []
    west_walls = []

    # west walls
    (1..lines).each do |i|
      wall = Wall.new(line + i, column)
      # walls << wall
      west_walls << wall
    end

    # east walls
    (1..lines).each do |i|
      wall = Wall.new(line + i, column + columns)
      # walls << wall
      east_walls << wall
    end

    # north walls
    (1..columns + 1).each do |i|
      wall = Wall.new(line, (column + i) - 1)
      # walls << wall
      north_walls << wall
    end

    # south walls
    (1..columns).each do |i|
      wall = Wall.new(line + lines, column + i)
      # walls << wall
      south_walls << wall
    end

    @north_walls = north_walls
    @south_walls = south_walls
    @east_walls = east_walls
    @west_walls = west_walls

    walls = @north_walls + @south_walls + @east_walls + @west_walls

    walls
  end
end
