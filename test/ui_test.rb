# frozen_string_literal: true

require 'minitest/autorun'
require 'terminfo'
require_relative '../src/ui'

class TestUI < Minitest::Test
  def setup
    @ui = UI.new
  end

  def test_that_ui_can_get_lines_and_columns
    expected_lines, expected_columns = TermInfo.screen_size

    actual_lines = @ui.lines
    actual_columns = @ui.columns

    assert_equal(expected_lines, actual_lines)
    assert_equal(expected_columns, actual_columns)
  end
end
