# frozen_string_literal: true

# The authority on which actions should be taken on input.
class Oracle
  def initialize
    @player = nil
  end

  attr_writer :player

  def parse(input)
    case input
    when 'w'
      @player.move_up
    when 'a'
      @player.move_left
    when 's'
      @player.move_down
    when 'd'
      @player.move_right
    end
  end
end
