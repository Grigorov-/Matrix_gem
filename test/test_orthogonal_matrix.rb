require_relative './test_helper'

class Orthogonal_Matrix_GemTest < Minitest::Test
  include MatrixErr

  def setup
    @matrix = Mat::Orthogonal.new(2,2)
  end

  def test_initialize
    assert_instance_of Mat::Orthogonal, @matrix
    assert_raises(MatrixArgumentError){ Mat::Orthogonal.new(2,23,1,1) }
  end

  def test_modify_element
    @matrix[1,1] = -1
    modified = @matrix
    assert_equal @matrix, modified
    assert_raises(MatrixIndexOutOfRange){ @matrix[1,1] = 5 }
  end
end