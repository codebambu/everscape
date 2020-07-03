# frozen_string_literal: true

class Player
  def initialize
    @character = '@'
    @line = 0
    @column = 0
  end
  
  def line
    @line
  end

  def column
    @column
  end

  def column=(column)
    @column = column
  end
  
  def line=(line)
    @line = line
  end

  def to_s
    @character
  end

  def move_left
    @column = @column - 1
  end

  def move_right
    @column = @column + 1
  end

  def move_up
    @line = line - 1
  end

  def move_down
    @line = line + 1
  end
end
