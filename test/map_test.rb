# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/everscape/map'

class TestMap < Minitest::Test
  def setup
    @map_size = 10
    cell_size = [5, 5]
    room_count = 14
    @map = Map.new(@map_size, @map_size)
  end

  def test_grid_is_correct_size
    assert_equal(@map_size, @map.grid.size)
    @map.grid.each do |line|
      assert_equal(@map_size, line.size)
    end
  end
end
