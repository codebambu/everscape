class Floor
  attr_reader :line, :column

  def initialize(line, column)
    @line = line
    @column = column
    @character = '.'
  end

  def to_s
    @character
  end
end
