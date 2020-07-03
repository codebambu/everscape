# frozen_string_literal: true

require 'terminfo'

class UI
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

  def paint(matrix)
    system('clear')

    for line in 1..matrix.size do
      current_line = line - 1
      for column in 1..matrix[current_line].size do
        current_column = column - 1

        print matrix[current_line][current_column]
      end
    end
  end
  # methods like paint/draw to draw input (from map)
  # methods like clear to clear the screen
  # everything related to displaying the map basically
end
