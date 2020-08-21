class Player
  attr_accessor :line, :column
  attr_writer :map
  def initialize
    @character = '@'
    @line = 1
    @column = 1
  end

  def to_s
    @character
  end

  def parse_command(command)
    case command
    when 'w'
      move_up
    when 'a'
      move_left
    when 's'
      move_down
    when 'd'
      move_right
    end
  end

  # commands

  def move_left
    collides = handle_collision(@line, @column -1)
    @column -= 1 unless collides
  end

  def move_right
    collides = handle_collision(@line, @column + 1)
    @column += 1 unless collides
  end

  def move_up
    collides = handle_collision(@line - 1, @column)
    @line -=1 unless collides
  end

  def move_down
    collides = handle_collision(@line + 1, @column)
    @line += 1 unless collides
  end

  def handle_collision(line, column)
    return @map.grid[line][column].class == Wall
  end
end
