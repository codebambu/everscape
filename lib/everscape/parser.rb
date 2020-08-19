# frozen_string_literal: true

require 'io/console'

# Takes and parses user input,then sends it off to the player
class Parser
  attr_writer :player

  def parse(command)
    if command == "\u0003" # CTRL-C to exit
      system('setterm -cursor on')
      system('stty echo')
      exit
    end

    @player.parse_command(command)
  end
end
