require_relative 'wall'

class Corridor
  def initialize(orientation, path)
    @orientation = orientation
    @path = path
    @walls = []

    if orientation == 'horizontal'
      create_horizontal_walls
    elsif orientation == 'vertical'
      create_vertical_walls
    end
  end

  def walls
    @walls
  end

  def create_horizontal_walls
    @path.each_with_index do |position, index|
      if index != 0 || index != @path.length - 1
        @walls << Wall.new(position[0] + 1, position[1])
        @walls << Wall.new(position[0] - 1, position[1])
      end
    end
  end

  def create_vertical_walls
    @path.each_with_index do |position, index|
      if index != 0 || index != @path.length - 1
        @walls << Wall.new(position[0], position[1] + 1)
        @walls << Wall.new(position[0], position[1] - 1)
      end
    end
  end
end
