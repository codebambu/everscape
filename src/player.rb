# frozen_string_literal: true

# The playable character on the screen.
class Player
  def initialize
    @character = '@'
    @line = 0
    @column = 0
  end

  attr_reader :line

  attr_reader :column

  attr_writer :column

  attr_writer :line

  def to_s
    @character
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
