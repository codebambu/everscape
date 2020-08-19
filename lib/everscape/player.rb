# frozen_string_literal: true

# The playable character on the screen.
class Player
  def initialize
    @character = '@'
    @line = 0
    @column = 0
  end

  def line
    @line
  end

  def line=(line)
    @line = line
  end

  def column
    @column
  end

  def column=(column)
    @column = column
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

  def move_left
    @column -= 1
  end

  def move_right
    @column += 1
  end

  def move_up
    @line = line - 1
  end

  def move_down
    @line = line + 1
  end
end
