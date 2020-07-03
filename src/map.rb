# frozen_string_literal: true

class Map
  def initialize(lines, columns)
    @lines = lines
    @columns = columns
    @matrix = initialize_matrix(@lines, @columns)
    @objects = []
  end
    
  def lines
    @lines
  end

  def columns
    @columns
  end

  def matrix
    @matrix
  end

  def objects
    @objets
  end

  def objects=(objects)
    @objects = objects
  end

  def initialize_matrix(lines, columns)
    matrix = []

    for i in 1..lines do
      matrix << []
      for j in 1..columns do
        matrix[i-1] << '.'
      end
    end

    matrix
  end

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


  # methdods for modifying things on the map
  # methods for iterating over entities and putting them on the map
end
