class Floor
  def initialize(line, column)
    @line = line
    @column = column
    @character = '.'
  end

  def line
    @line
  end

  def column
    @column
  end

  def to_s
    @character
  end
end
