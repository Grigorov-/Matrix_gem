require 'minitest/autorun'
require_relative '../lib/matrix_gem/matrix_err.rb'
require 'matrix_gem'

class Diagonal_Matrix_Test < Minitest::Test
  include MatrixErr

  def setup
<<<<<<< HEAD
    @id_matrix = Mat::Diagonal.new 3
    @square_matrix = Mat::Diagonal.new 3,3,1,3,5
    @non_square_matrix = Mat::Diagonal.new 3,2,1,12
  end

  def test_setup
    assert_instance_of Mat::Diagonal, @id_matrix
    assert_instance_of Mat::Diagonal, @square_matrix
    assert_instance_of Mat::Diagonal, @non_square_matrix
  end

  def test_initalize_errors
    assert_raises(MatrixArgumentError){ Mat::Diagonal.new 3,2,1,2,3 }
  end

  def test_initalize_class_methods
    assert_instance_of Mat::Diagonal, Mat::Diagonal.diagonal(2, 3, 3, 4)
    assert_instance_of Mat::Diagonal, Mat::Diagonal.zero(5)
    assert_instance_of Mat::Diagonal, Mat::Diagonal.identity(4)
=======
    @id_matrix = Diagonal_Matrix.new 3
    @square_matrix = Diagonal_Matrix.new 3,3,1,3,5
    @non_square_matrix = Diagonal_Matrix.new 3,2,1,12
  end

  def test_setup
    assert_instance_of Diagonal_Matrix, @id_matrix
    assert_instance_of Diagonal_Matrix, @square_matrix
    assert_instance_of Diagonal_Matrix, @non_square_matrix
  end

  def test_initalize_errors
    assert_raises(MatrixArgumentError){ Diagonal_Matrix.new 3,2,1,2,3 }
  end

  def test_initalize_class_methods
    assert_instance_of Diagonal_Matrix, Diagonal_Matrix.diagonal(2, 3, 3, 4)
    assert_instance_of Diagonal_Matrix, Diagonal_Matrix.zero(5)
    assert_instance_of Diagonal_Matrix, Diagonal_Matrix.identity(4)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
  end

  def test_change_matrix_element
    @id_matrix[1,1] = 2
    changed = @id_matrix
<<<<<<< HEAD
    assert_equal Mat::Diagonal.diagonal(1,2,1), changed
=======
    assert_equal Diagonal_Matrix.diagonal(1,2,1), changed
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_raises(MatrixIndexOutOfRange){ @id_matrix[1,2] = 4 }
  end

  def test_sum_with_different_type_matrices
<<<<<<< HEAD
    sum = Mat::Diagonal.diagonal(2, 5, 33)
    assert_equal sum, @id_matrix + Mat::Matrix.new(3,3,1,3,4,2,4,22,13,2,32)
=======
    sum = Diagonal_Matrix.diagonal(2, 5, 33)
    assert_equal sum, @id_matrix + Matrix.new(3,3,1,3,4,2,4,22,13,2,32)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
  end

  def test_sum_errors
    assert_raises(ErrDimensionMismatch){ @square_matrix + @non_square_matrix }
    assert_raises(ErrOperationNotDefine){ @square_matrix + 2 }
  end

  def test_difference_with_different_type_matrices
<<<<<<< HEAD
    diff = Mat::Matrix.diagonal(2,3,3)
    assert_equal diff, @square_matrix - Mat::Matrix.diagonal(-1,0,2)
  end

  def test_multiplication
    product = Mat::Diagonal.diagonal 1, 10, 0
    assert_equal product, Mat::Diagonal.new(3,2,1,2) * Mat::Matrix.new(2,3,1,2,3,4,5,6)
=======
    diff = Matrix.diagonal(2,3,3)
    assert_equal diff, @square_matrix - Matrix.diagonal(-1,0,2)
  end

  def test_multiplication
    product = Diagonal_Matrix.diagonal 1, 10, 0
    assert_equal product, Diagonal_Matrix.new(3,2,1,2) * Matrix.new(2,3,1,2,3,4,5,6)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
  end

  def test_multiplication_errors
    assert_raises(MatrixInvalidValue){ @square_matrix * @square_matrix }
    assert_raises(ErrDimensionMismatch){ @non_square_matrix * @square_matrix }
  end

  def test_division_errors
    assert_raises(NoSquareMatrix){ @square_matrix / @non_square_matrix }
<<<<<<< HEAD
    assert_raises(ErrDimensionMismatch){ Mat::Diagonal.new(3,2,1,2) / @square_matrix }
=======
    assert_raises(ErrDimensionMismatch){ Diagonal_Matrix.new(3,2,1,2) / @square_matrix }
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
  end

  def test_detrminant
    assert_equal 15, @square_matrix.det
    assert_raises(NoSquareMatrix){ @non_square_matrix.det }
  end
end