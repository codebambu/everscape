class Wall
  attr_reader :line, :column, :solid

  def initialize(line, column)
    @line = line
    @column = column
    @character = '#'
    @solid = true
  end

  def to_s
    @character
  end
end
