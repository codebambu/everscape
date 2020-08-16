# frozen_string_literal: true

require 'io/console'

# Takes and parses user input,then sends it off to the Oracle.
class Parser
  def initialize
    @oracle = nil
  end

  def input
    command = STDIN.getch

    if command == "\u0003" # CTRL-C to exit
      system('setterm -cursor on')
      system('stty echo')
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
