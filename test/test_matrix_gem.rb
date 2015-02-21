require 'minitest/autorun'
require_relative '../lib/matrix_gem/matrix_err.rb'
require 'matrix_gem'

class Matrix_GemTest < Minitest::Test
  include MatrixErr

  def setup
<<<<<<< HEAD
    @id_matrix = Mat::Matrix.new 3,3
    @square_matrix = Mat::Matrix.new 3,3,
                                    1,2,57,
                                    1,3,43,
                                    5,6,70
    @non_square_matrix = Mat::Matrix.new 3,2,
                                        1,2,
                                        3,3,
                                        2,3
  end

  def test_create_matrix
    assert_instance_of Mat::Matrix, @id_matrix, 'Identity matrix'
    assert_instance_of Mat::Matrix, @square_matrix, 'Square matrix'
    assert_instance_of Mat::Matrix, @non_square_matrix, 'Non square matrix'
  end

  def test_create_matrix_with_wrong_values
    assert_raises(MatrixArgumentError){ Mat::Matrix.new 0,1,2 }
    assert_raises(MatrixArgumentError){ Mat::Matrix.new 3,2,1,2,3 }
    assert_raises(MatrixArgumentError){ Mat::Matrix.new 2.2,2,2,1,3,4 }
    assert_raises(ArgumentError){ Mat::Matrix.new }
    assert_raises(MatrixArgumentError) { Mat::Matrix.new 2.3,2,1,2,3,4 }
  end

  def test_create_matrix_with_nil_values
    assert_raises(NoMethodError){ Mat::Matrix.new 2,nil }
    assert_raises(ArgumentError){ Mat::Matrix.diagonal nil,2,3 }
    assert_raises(NoMethodError){ Mat::Matrix.zero  nil }
    assert_raises(NoMethodError){ Mat::Matrix.identity(nil) }
  end

  def test_create_zero_matrix
    assert_equal true, Mat::Matrix.zero(3).zero?
  end

  def test_create_diagonal_elements
    matrix = Mat::Matrix.diagonal(1,2,34.3,2)
    assert_equal true, matrix.diagonal?, "Test diagonal? property"
    assert_instance_of Mat::Matrix, matrix, "Matrix using diagonal method"
  end

  def test_create_identity_matrix
    assert_instance_of Mat::Matrix, Mat::Matrix.identity(4), 'Matrix using identity method'
  end

  def test_sum_matrices
    sum = Mat::Matrix.new 3,3,
                          2,2,57,
                          1,4,43,
                          5,6,71
=======
    @id_matrix = Matrix.new 3,3
    @square_matrix = Matrix.new 3,3,1,2,57,1,3,43,5,6,70
    @non_square_matrix = Matrix.new 3,2,1,2,3,3,2,3
  end

  def test_create_matrix
    assert_instance_of Matrix, @id_matrix, 'Identity matrix'
    assert_instance_of Matrix, @square_matrix, 'Square matrix'
    assert_instance_of Matrix, @non_square_matrix, 'Non square matrix'
  end

  def test_create_matrix_with_wrong_values
    assert_raises(MatrixArgumentError){ Matrix.new 0,1,2 }
    assert_raises(MatrixArgumentError){ Matrix.new 3,2,1,2,3 }
    assert_raises(MatrixArgumentError){ Matrix.new 2.2,2,2,1,3,4 }
    assert_raises(ArgumentError){ Matrix.new }
    assert_raises(MatrixArgumentError) { Matrix.new 2.3,2,1,2,3,4 }
  end

  def test_create_matrix_with_nil_values
    assert_raises(NoMethodError){ Matrix.new 2,nil }
    assert_raises(ArgumentError){ Matrix.diagonal nil,2,3 }
    assert_raises(NoMethodError){ Matrix.zero  nil }
    assert_raises(NoMethodError){ Matrix.identity(nil) }
  end

  def test_create_zero_matrix
    assert_equal true, Matrix.zero(3).zero?
  end

  def test_create_diagonal_elements
    matrix = Matrix.diagonal(1,2,34.3,2)
    assert_equal true, matrix.diagonal?, "Test diagonal? property"
    assert_instance_of Matrix, matrix, "Matrix using diagonal method"
  end

  def test_create_identity_matrix
    assert_instance_of Matrix, Matrix.identity(4), 'Matrix using identity method'
  end

  def test_sum_matrices
    sum = Matrix.new 3,3,2,2,57,1,4,43,5,6,71
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_equal sum, @square_matrix + @id_matrix, 'Sum matrices'
  end

  def test_sum_errors
    assert_raises(ErrDimensionMismatch){ @square_matrix + @non_square_matrix }
  end

  def test_difference_of_
<<<<<<< HEAD
    diff = Mat::Matrix.new 3,3,
                          0,2,57,
                          1,2,43,
                          5,6,69
=======
    diff = Matrix.new 3,3,0,2,57,1,2,43,5,6,69
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_equal diff, @square_matrix - @id_matrix, 'Difference of matrices'
  end

  def test_multiplication
<<<<<<< HEAD
    scalar_product = Mat::Matrix.new 3,3,
                                    -2,-4,-114,
                                    -2,-6,-86,
                                    -10,-12,-140
    matr_product = Mat::Matrix.new 3,3,
                                  121,63,176,
                                  96,51,135,
                                  163,92,231
    multipicator = Mat::Matrix.new 3,3,
                                  1,2,3,
                                  3,2,1,
                                  2,1,3
    assert_equal scalar_product, @square_matrix * -2
    assert_equal matr_product, @square_matrix * multipicator
  end

  def test_matrix_on_power
    assert_equal Mat::Matrix.new(3,3,6,12,18,6,12,18,6,12,18), Mat::Matrix.new(3,3,1,2,3,1,2,3,1,2,3)**2
  end

  def test_minor_method
    assert_equal Mat::Matrix.new(2,3,
                                1,2,57,
                                1,3,43), @square_matrix.minor(0..1, 0..2)
=======
    scalar_product = Matrix.new 3,3,-2,-4,-114,-2,-6,-86,-10,-12,-140
    matr_product = Matrix.new 3,3,121,63,176,96,51,135,163,92,231
    b = Matrix.new 3,3,1,2,3,3,2,1,2,1,3
    assert_equal scalar_product, @square_matrix * -2
    assert_equal matr_product, @square_matrix * b
  end

  def test_matrix_on_power
    assert_equal Matrix.new(3,3,6,12,18,6,12,18,6,12,18), Matrix.new(3,3,1,2,3,1,2,3,1,2,3)**2
  end

  def test_minor_method
    assert_equal Matrix.new(2,3,1,2,57,1,3,43), @square_matrix.minor(0..1, 0..2)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_nil @square_matrix.minor(0..1, -223..2)
  end

  def test_multiplication_with_dimension_mismatch_matrices
    assert_raises(ErrDimensionMismatch){ @non_square_matrix * @square_matrix }
  end

  def test_division
<<<<<<< HEAD
    a = Mat::Matrix.new 3,2,
                        1,2,
                        3,3,
                        2,3
    b = Mat::Matrix.new 2,2,
                        1,1,
                        2,1
    division_result = Mat::Matrix.new 3,2,
                                      3,-1,
                                      3,0,
                                      4,-1
    scalar_division_result = Mat::Matrix.new 2,2,
                                            0.5,0.5,
                                            1,0.5
=======
    a = Matrix.new 3,2,1,2,3,3,2,3
    b = Matrix.new 2,2,1,1,2,1
    division_result = Matrix.new 3,2,3,-1,3,0,4,-1
    scalar_division_result = Matrix.new 2,2,0.5,0.5,1,0.5
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_equal scalar_division_result, b / 2, "Division scalar test"
    assert_equal division_result, a / b, "Division test"
  end

  def test_square_brackets
    assert_equal [1,0,0], @id_matrix[0], "[] row test"
    assert_equal 0, @id_matrix[0,1], "[] element test"
  end

  def test_set_row
    @id_matrix[0] = [1,1,1]
    changed_matrix = @id_matrix
<<<<<<< HEAD
    assert_equal(Mat::Matrix.new(3,3,
                                1,1,1,
                                0,1,0,
                                0,0,1), changed_matrix,
=======
    assert_equal(Matrix.new(3,3,1,1,1,0,1,0,0,0,1), changed_matrix,
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
      "Set identity matrix row")
  end

  def test_set_row_error
    assert_raises(ErrDimensionMismatch){ @square_matrix[0] = [1,1] }
  end

  def test_set_element
    @square_matrix[0,0] = 555
    changed_matrix = @square_matrix
<<<<<<< HEAD
    assert_equal Mat::Matrix.new(3,3,
                                555,2,57,
                                1,3,43,
                                5,6,70), changed_matrix,
=======
    assert_equal Matrix.new(3,3,555,2,57,1,3,43,5,6,70), changed_matrix,
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    "Test to set element to square_matrix"
  end

  def test_transpose
<<<<<<< HEAD
    assert_equal Mat::Matrix.new(3,3,
                                1,1,5,
                                2,3,6,
                                57,43,70), @square_matrix.t
  end

  def test_equal_matrices
    assert_equal Mat::Matrix.new(2,2,
                                1,3,
                                4,12), Mat::Matrix.new(2,2,
                                                      1,3,
                                                      4,12)
=======
    assert_equal Matrix.new(3,3,1,1,5,2,3,6,57,43,70), @square_matrix.t
  end

  def test_equal_matrices
    assert_equal Matrix.new(2,2,1,3,4,12), Matrix.new(2,2,1,3,4,12)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
  end

  def test_equal_matrices_errors
    assert_same false, @square_matrix == @non_square_matrix
  end

  def test_determinant
    assert_same(-271, @square_matrix.det)
  end

  def test_diagonal_values
    assert_equal [1,1,1], @id_matrix.diagonal_values
  end

  def test_to_set_diagonal_values
<<<<<<< HEAD
    assert_equal Mat::Matrix.new(3,2,
                                11,2,
                                3,11,
                                2,3), @non_square_matrix.set_diagonal(11,11)
=======
    assert_equal Matrix.new(3,2,11,2,3,11,2,3), @non_square_matrix.set_diagonal(11,11)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
  end

  def test_col_length
    assert_same(3, @non_square_matrix.m)
  end

  def test_row_length
    assert_same(2, @non_square_matrix.n)
  end

  def test_row_method
    assert_equal [1,2], @non_square_matrix.row(0)
  end

  def test_col_method
    assert_equal [1,3,2], @non_square_matrix.col(0)
  end

  def test_set_row
<<<<<<< HEAD
    assert_equal Mat::Matrix.new(3,3,
                                100,200,300,
                                0,1,0,
                                0,0,1),
=======
    assert_equal Matrix.new(3,3,100,200,300,0,1,0,0,0,1),
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
      @id_matrix.set_row(0, [100, 200, 300])
  end

  def test_set_col
<<<<<<< HEAD
    assert_equal Mat::Matrix.new(3,3,
                                1,11,0,
                                0,11,0,
                                0,11,1),
=======
    assert_equal Matrix.new(3,3,1,11,0,0,11,0,0,11,1),
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    @id_matrix.set_col(1, [11, 11, 11])
  end

  def test_is_diagonal
    assert(@id_matrix.is_diagonal)
    assert_equal(false, @square_matrix.diagonal?)
  end

  def test_is_zero
<<<<<<< HEAD
    assert Mat::Matrix.new(2,2,
                          0,0,
                          0,0).zero?
=======
    assert Matrix.new(2,2,0,0,0,0).zero?
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_equal false, @non_square_matrix.zero?
  end

  def test_is_square
    assert @square_matrix.square?
    assert_equal false, @non_square_matrix.square?
  end

  def test_is_orthogonal
<<<<<<< HEAD
    assert Mat::Matrix.new(2,2).orthogonal?
=======
    assert Matrix.new(2,2).orthogonal?
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
    assert_equal false, @square_matrix.orthogonal?
  end

end
