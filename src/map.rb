# frozen_string_literal: true

# The world contained in a matrix.
class Map
  def initialize(lines, columns)
    @lines = lines
    @columns = columns
    @matrix = initialize_matrix(@lines, @columns)
    @objects = []
  end

  attr_reader :lines

  attr_reader :columns

  attr_reader :matrix

  def objects
    @objets
  end

  attr_writer :objects

  def initialize_matrix(lines, columns)
    matrix = []

    (1..lines).each do |i|
      matrix << []
      (1..columns).each do |_j|
        matrix[i - 1] << '.'
      end
    end

    matrix
  end

  def add_rooms; end

  def update_matrix
    @matrix = initialize_matrix(@lines, @columns)

    @objects.each do |object|
      @matrix[object.line][object.column] = object
    end
  end

  def add_object(object)
    @objects << object
    update_matrix
  end
end
