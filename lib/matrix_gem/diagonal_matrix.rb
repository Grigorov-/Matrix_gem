require_relative  '../matrix_gem'

  class Diagonal_Matrix < Matrix

    # Creates a matrix by given rows, columns, and nums where the diagonal elements are composed of nums.
    # With given only rows create identity matrix.
    def initialize(rows, cols = nil, *nums)
      if cols == nil
        @matrix = identity rows
      elsif nums.length != [rows, cols].min
        raise MatrixArgumentError,
        "Wrong number of arguments (#{2 + nums.length} for #{2 + [rows, cols].min})"
      else
        @matrix = []
        rows.times do |row|
          @matrix[row] = []
          cols.times do |col|
            if row == col
              @matrix[row][col] = nums[row]
            else
              @matrix[row][col] = 0
            end
          end
        end
      end
    end

    class << self
      # Creates a matrix where the diagonal elements are composed of nums.
      def diagonal(*nums)
        size = nums.length
        Diagonal_Matrix.new size, size, *(nums)
      end

      # Creates a zero matrix with dimension equal to n.
      def zero(n)
        Diagonal_Matrix.diagonal(*(Array.new(n, 0)))
      end

      def identity(n)
        Diagonal_Matrix.new n
      end
    end

    # Set element on main diagonal
    def []=(i, j = nil, value)
      if j != nil && i != j
        raise MatrixIndexOutOfRange,
        "You can set only elements on main diagonal in a diagonal matrix."
      elsif @matrix.size <= i
        raise MatrixIndexOutOfRange
      end
        @matrix[i][i] = value
    end

    # Sum values on main diagonal of two matrices.
    # Raises error if 'matrix' is not a Matrix or if matrices dimensions mismatch.
    def +(matrix)
      sum_validation(self, matrix)
      values = self.diagonal_values.zip(matrix.diagonal_values).map{ |i| i.inject(:+) }
      Diagonal_Matrix.new self.m, self.n, *(values)
    end

    # Returns the difference of values on main diagonal of two matrices in new matrix.
    # Raises error if 'matrix' is not a Matrix or if matrices dimensions mismatch.
    def -(matrix)
      sum_validation(self, matrix)
      values = self.diagonal_values.zip(matrix.diagonal_values).map{ |i| i.inject(:-) }

      Diagonal_Matrix.new self.m, self.n, *(values)
    end

    # Matrix multiplication. Returns new instance of Diagonal_Matrix.
    # Raises error if product can't be instance of Diagonal_Matrix.
    def *(matrix)
      product = super(matrix)
      raise MatrixInvalidValue, "Product of multiplication is not diagonal matrix." if product.diagonal?

      Diagonal_Matrix.new(product.m, product.n, *(product.diagonal_values))
    end

    # Matrix division (multiplication by the inverse).
    # Raises error if difference can't be instance of Diagonal_Matrix.
    # Raises error if matrix is not invertible.
    def /(matrix)
      diff = super(matrix)
      raise MatrixInvalidValue, "Difference of matrices in not a diagonal matrix." if diff.diagonal?

      Diagonal_Matrix.new(diff.m, diff.n, *(diff.diagonal_values))
    end

    # Returns the determinant of the matrix.
    def det
      is_square_validation self
      self.diagonal_values.reduce(:*)
    end

    private

    def non_main_diagonal_elements?(matrix)
      matrix.m.times do |i|
        matrix.n.times do |j|
          return true if ((i != j) && (matrix[i,j] != 0))
        end
      end
      false
    end
  end

   # id_matrix = Diagonal_Matrix.diagonal(1.0,1,1)
    square_matrix = Diagonal_Matrix.new 3,3,1,3,5
    a = Diagonal_Matrix.new 3,2,3,4
    diff = Matrix.new 2,3,1,2,3,4,5,6
    d = Diagonal_Matrix.new 3,2,1,2
    # p d / square_matrix
    non_square_matrix = Diagonal_Matrix.new 3,2,1,12



