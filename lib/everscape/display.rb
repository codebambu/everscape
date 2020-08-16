# frozen_string_literal: true

require 'terminfo'

# The display takes care of drawing the map onto the screen.
class Display
  def initialize
    @lines, @columns = TermInfo.screen_size
    @map = nil

    system('setterm -cursor off')
    system('stty -echo')
  end

  def lines
    @lines
  end

  def columns
    @columns
  end

  def map=(map)
    @map = map
  end

  def draw(matrix)
    output = ''

    (1..matrix.size).each do |line|
      current_line = line - 1
      (1..matrix[current_line].size).each do |column|
        current_column = column - 1

        output += matrix[current_line][current_column].to_s
      end
    end

    print output
  end
end
