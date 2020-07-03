# frozen_string_literal: true

require 'terminfo'

class Display
  def initialize
    @lines, @columns = TermInfo.screen_size
    @map = nil

    system('setterm -cursor off')
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
    system('clear')
    output = ''

    for line in 1..matrix.size do
      current_line = line - 1
      for column in 1..matrix[current_line].size do
        current_column = column - 1

        output = output + matrix[current_line][current_column].to_s
      end
    end

    print output
  end
  # methods like paint/draw to draw input (from map)
  # methods like clear to clear the screen
  # everything related to displaying the map basically
end
