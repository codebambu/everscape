# frozen_string_literal: true

class Oracle
  def initialize
    @player = nil
    # take input string
    # find player based on classname from map entities
    # take player position
    # find where the player wants to go
    # find what is there
    # instruct player to perform action
    # instruct main to e.g. remove entity by id?
  end
  
  def player=(player)
    @player = player
  end

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
