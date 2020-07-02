# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/ui'

class TestUI < Minitest::Test
  def setup
    @ui = UI.new
  end

  def test_that_ui_can_get_lines
    skip 'test this later'
  end

  def test_that_ui_can_get_columns
    skip 'test this later'
  end

  def test_that_will_be_skipped
    skip 'test this later'
  end
end
