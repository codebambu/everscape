# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/map'

class TestMap < Minitest::Test
  def setup
    @map = Map.new(10, 10)
  end

  def test_matrix_is_correct_size
    assert_equal(10, @map.matrix.size)
    @map.matrix.each do |line|
      assert_equal(10, line.size)
    end
  end
end

