require 'minitest/autorun'
require_relative '../lib/matrix_gem/matrix_err.rb'
require 'matrix_gem'

class Orthogonal_Matrix_GemTest < Minitest::Test
  include MatrixErr

  def setup
    @matrix = Orthogonal_Matrix.new(2,2)
  end

  def test_initialize
    assert_instance_of Orthogonal_Matrix, @matrix
    assert_raises(MatrixArgumentError){ Orthogonal_Matrix.new(2,23,1,1) }
  end

  def test_modify_element
    @matrix[1,1] = -1
    modified = @matrix
    assert_equal @matrix, modified
    assert_raises(MatrixIndexOutOfRange){ @matrix[1,1] = 5 }
  end
end
