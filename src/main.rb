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
    @parser.oracle = @oracle
    # link parser and oracle
    # todo
    @player = Player.new
    @oracle.player = @player
    # entities
    @entities = [@player]

    # give entities to map
    @map = Map.new(@ui.lines, @ui.columns)

    @entities.each do |entity|
      @map.add_object(entity)
    end
    # link map and oracle
    # link oracle and main to communicate about entities
    # methods for adding and removing entities
    # todo
  end

  def start
    while true
      @map.objects = @entities
      @map.update_matrix
      @ui.paint(@map.matrix)
      input = @parser.get_input
      @parser.parse(input)
    end
  end
end
