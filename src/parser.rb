# frozen_string_literal: true

require 'io/console'

class Parser
  def initialize
    @oracle = nil
  end

  def get_input
    command = STDIN.getch

    if command == "\u0003" # CTRL-C to exit
      system('setterm -cursor on')
      exit
    end
    
    command
  end
    
  def oracle=(oracle)
    @oracle = oracle
  end

  def parse(input)
    @oracle.parse(input)
  end
end
