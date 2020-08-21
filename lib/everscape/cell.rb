class Cell
  attr_reader :line1, :line2, :column1, :column2, :size

  def initialize(line, column, size)
    @size = size
    (@lines, @columns) = size
    @line1 = line
    @line2 = line + @lines
    @column1 = column
    @column2 = column + @columns
  end
end
