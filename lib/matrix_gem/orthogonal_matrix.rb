<<<<<<< HEAD
module Mat
  class Orthogonal < Mat::Matrix

  # Initialize orthogonal matrix (square matrix and its transpose is equal to its inverse).
    def initialize(rows, cols = rows, *nums)
=======
  class Orthogonal_Matrix < Matrix

  # Initialize orthogonal matrix (square matrix and its transpose is equal to its inverse).
    def initialize(rows, cols, *nums)
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
      if !(Matrix.new rows, cols, *(nums)).orthogonal?
        raise MatrixArgumentError,
        "Can't initialize orthogonal matrix with this values."
      elsif nums.length == 0
          @matrix = identity rows
      else
        @matrix = matrix_with_values nums, cols
      end
    end

    # Set element.
    # Raise error if the matrix with new value is not orthogonal.
    def []=(i, j, value)
      b = copy(self)
      b[i,j] = value
      if b.orthogonal?
        @matrix[i][j] = value
      else
        raise MatrixIndexOutOfRange, 'The matrix must be orthogonal.'
      end
    end
<<<<<<< HEAD
  end
end
=======
  end
>>>>>>> 04fac2ac30078c34289c819de09a204166178008
