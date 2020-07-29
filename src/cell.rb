class Cell
  def initialize(line, column, size)
    @size = size
    (@lines, @columns) = size
    @line1 = line
    @line2 = line + @lines
    @column1 = column
    @column2 = column + @columns
  end

  def line1
    @line1
  end

  def line2
    @line2
  end

  def column1
    @column1
  end

  def column2
    @column2
  end

  def size
    @size
  end
end
