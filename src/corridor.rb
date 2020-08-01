require_relative 'wall'

class Corridor
  def initialize(path)
    @walls = create_walls(path)
  end

  def walls
    @walls
  end

  # TODO make distinction between horuizontal and vercial walls
  def create_walls(path)
    walls = []

    path.each do |position|
      walls << Wall.new(position[0], position[1])
    end

    return walls
  end
end
