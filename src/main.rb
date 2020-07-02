# frozen_string_literal: true

require_relative 'map'
require_relative 'parser'
require_relative 'oracle'
require_relative 'player'
require_relative 'ui'

class Main
  def initialize
    # base things
    @ui = UI.new
    @oracle = Oracle.new
    @parser = Parser.new
    # link parser and oracle
    # todo

    # entities
    @entities = [Player.new]

    # give entities to map
    @map = Map.new
    # link map and oracle
    # link map and ui
    # link oracle and main to communicate about entities
    # methods for adding and removing entities
    # todo
  end
end
