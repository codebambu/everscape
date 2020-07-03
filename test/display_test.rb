# frozen_string_literal: true

require 'minitest/autorun'
require 'terminfo'
require_relative '../src/display'

class TestDisplay < Minitest::Test
  def setup
    @display = Display.new
  end

  def test_that_display_can_get_lines_and_columns
    expected_lines, expected_columns = TermInfo.screen_size

    actual_lines = @display.lines
    actual_columns = @display.columns

    assert_equal(expected_lines, actual_lines)
    assert_equal(expected_columns, actual_columns)
  end
end
