# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/everscape/map'

class TestMap < Minitest::Test
  def setup
    @map_size = 10
    cell_size = [5, 5]
    room_count = 14
    @map = Map.new(@map_size, @map_size, cell_size, room_count)
  end

  def test_grid_is_correct_size
    assert_equal(@map_size, @map.grid.size)
    @map.grid.each do |line|
      assert_equal(@map_size, line.size)
    end
  end

  def test_map_creates_correct_amount_of_cells
    expected_size = 1
    assert_equal(expected_size, @map.create_cells.size)
  end
end
