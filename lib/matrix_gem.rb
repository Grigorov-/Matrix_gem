require_relative 'matrix_gem/matrix_err'
require_relative 'matrix_gem/properties_module'

  class Matrix
    include MatrixErr
    include Properties
    include Enumerable

    #---------Initialize the matrix--------
    #  1. Matrix with values
    #     Matrix.new(rows, cols, numbers) // numbers = rows*cols
    #  2. Matrix only with dimension(rows and cols) make Identity matrix with dimension
    #     equal to rows
    #     Matrix.new(rows, cols)
    def initialize(rows, cols, *nums)
      if rows < 1 || cols < 1
        raise MatrixArgumentError, "Rows and Columns should be positive numbers!"
      elsif ((cols.is_a? Float) || (rows.is_a? Float))
        raise MatrixArgumentError, "Dimension of matrix can't be floating point number"
      elsif nums.length == 0
        @matrix = identity rows
      elsif rows * cols == nums.length
        @matrix = matrix_with_values nums, cols
      else
        raise MatrixArgumentError,
        "Wrong number of arguments (#{2 + nums.length} for #{2 + rows * cols})"
      end
      @matrix
    end

    class << self

      # Creates an n by n zero matrix.
      def zero(n)
        values = Array.new(n*n, 0)
        matrix = Matrix.new n, n, *(values)
      end

      # Creates a matrix where the diagonal elements are composed of values.
      def diagonal(*nums)
        size = nums.size
        matrix = Matrix.new size, size

        size.times do |x|
          matrix[x][x] = nums[x]
        end
        matrix
      end

      # Creates an n by n identity matrix.
      def identity(n)
        Matrix.new n, n
      end
    end

    # Return the sum of two matrices in new matrix
    # Raises an error if matrices dimension mismatch.
    def +(matrix)
      sum_validation(self, matrix)
      values = self.zip(matrix).map{ |i| i.inject(:+) }

      Matrix.new self.m, self.n, *(values)
    end

    # Return the difference of two matrices in new matrix.
    # Raises an error if matrices dimension mismatch.
    def -(matrix)
      sum_validation(self, matrix)
      values = self.zip(matrix).map{|i| i.inject(:-)}

      Matrix.new self.m, self.n, *(values)
    end

    # Matrix multiplication.
    def *(matrix)
      case(matrix)
      when Numeric
        new_matrix_values = []
        self.each { |x| new_matrix_values << x * matrix }
        Matrix.new self.m, self.n, *(new_matrix_values)
      when Matrix
        multiply_validation self, matrix
        rows = Array.new(self.m) { |i|
          Array.new(matrix.n) { |j|
            (0 ... self.n).inject(0) do |vij, k|
              vij + self[i, k] * matrix[k, j]
            end
          }
        }
        values = []
        rows.each{ |x| x.each { |y| values << y} }
        Matrix.new self.m, matrix.n, *(values)
      end
    end

    # Matrix division (multiplication by the inverse).
    def /(matrix)
      case matrix
      when Numeric
        new_matrix_values = []
        self.each { |x| new_matrix_values << x / matrix.to_f }
        Matrix.new self.m, self.n, *(new_matrix_values)
      when Matrix
        self * matrix.inversed
      end
    end

    # Returns element (i,j) of the matrix. That is: row i, column j.
    # If only i is given return row[i]. That is: row with index i.
    def [](i, j = nil)
      if j == nil
        @matrix[i]
      else
        @matrix[i][j]
      end
    end

    # Set element (i,j) of the matrix. That is: row i, column j.
    # Set row i of the matrix if j is not given. That is: column j.
    # Also aliased as set_element
    def []=(i, j = nil, val)
      if j == nil
        raise ErrDimensionMismatch if val.length != self.m
        @matrix[i] = val
      elsif (i < self.m && j < self.n)
        @matrix[i][j] = val
      end
    end
    alias set_element []=

    # Return a new matrix which is the transposition of the given one.
    def transposed
      elements = []
      @matrix.to_a.transpose.map{ |x| x.map{ |y| elements << y } }
      Matrix.new self.m, self.n, *(elements)
    end

    # Transpose the matrix.
    # Also aliased as t().
    def transpose
      elements = []
      @matrix.to_a.transpose.map{ |x| x.map{ |y| elements << y } }
      @matrix = elements.each_slice(@matrix[0].length).to_a
      self
    end
    alias t transpose

    #Each method.
    def each
      @matrix.each do |sub_arr|
        sub_arr.each do |value|
          yield value
        end
      end
    end

    # Returns true if and only if the two matrices contain equal elements.
    def ==(matrix)
      (0..self.m-1).each do |i|
        (0..self.n-1).each do |j|
          return false if self[i][j] != matrix[i][j]
        end
      end
      true
    end

    # Returns the determinant of the matrix.
    # Also alised as determinant()
    def det
      is_square_validation self

      _this = copy(self)
      c = 1
      new_matrix = nil
      size = _this.n

      (0..size - 2).each do |i|
        (i + 1..size -1).each do |j|
          if _this[i][i] == 0
            (i+1..size-1).each do |k|
              if _this[k,i] != 0
                swap_rows(_this, k, i)
                c *= -1
              end
            end
          end
          if _this[i,i] == 0
            return 0
          end

          new_matrix = cauchy_method(_this, i, j, -_this[j,i]/_this[i,i].to_f)
        end
      end

      det = 1

      (0..size-1).each do |i|
        det *= new_matrix[i][i]
      end

      det *= c
      det.round
    end
    alias determinant det

    # Returns new matrix witch is the inverse of the matrix.
    def inversed
      is_square_validation self
      raise ErrZeroDeterminant if self.det == 0

      _this = copy(self)
      c = 1
      e = Matrix.new _this.m, _this.n
      size = _this.m

      (0..size-2).each do |i|
        (i+1..size-1).each do |j|
          if _this[i, i] == 0
            (i..size-2).each do |k|
              if _this[k, i] != 0
                swap_rows(_this, k, i)
                swap_rows(e, k, i)
                c *= -1
              end
            end
          end

          return 0 if _this[i, i] == 0

          cauchy_method(e, i, j, -_this[j, i]/_this[i, i].to_f)
          cauchy_method(_this, i, j, -_this[j, i]/_this[i, i].to_f)
        end
      end

      (0..size-2).each do |i|
        (i+1..size-1).each do |j|

          cauchy_method(e, size-i-1, size-j-1, -_this[size-j-1, size-i-1]/_this[size-i-1, size-i-1])

          cauchy_method(_this, size-i-1, size-j-1, -_this[size-j-1, size-i-1]/_this[size-i-1, size-i-1])
        end
      end

      (0..size-1).each do |i|
        e.set_row i, multiply_row(e, i, 1/_this[i,i])
        _this.set_row i, multiply_row(_this, i, 1/_this[i,i])
      end
        Matrix.new self.m, self.m, *(e)
      end

    # Chanege matrix to its inversed.
    def inverse
      elements = []
      self.inversed.each{ |x| elements << x}
      @matrix = elements.each_slice(@matrix[0].length).to_a
      self
    end

    # To stirng method.
    def to_str
      a = "Matrix\n" + @matrix.map do |row|
        "[" + row.map do |e|
           e.to_s
        end.join(" ") + "]"
      end.join(",\n")
      puts a
    end

    private

    # Swap to matrix rows.
    def swap_rows(_this, row1_index, row2_index)
      _this[row1_index], _this[row2_index] = _this[row2_index], _this[row1_index]
    end

    # Return new instance of Matrix with same values.
    def copy(_this)
      values = []
      _this.each{ |row| values << row }
      copy = Matrix.new _this.m, _this.n, *(values)
    end

    # Multiply the first row elements with multiplier and sum it with second row
    # elements.
    # Used to make matrix in triangular form.
    def cauchy_method(_this, row1_index, row2_index, multiplier)
      _this.row(row2_index).each_with_index do |row_element, i|
        _this.row(row2_index)[i] += _this[row1_index][i] * multiplier
      end
      _this
    end

    # Check if caller matrix columns are equal to other matrix rows.
    def multiply_validation(_this, matrix)
      raise ErrDimensionMismatch if _this.col_size != matrix.row_size
    end

    # Check if matrix rows are equals to its columns.
    def is_square_validation(_this)
      raise NoSquareMatrix if _this.m != _this.n
    end

    # Check if matrices have same dimensions.
    def sum_validation(_this, matrix)
      raise ErrOperationNotDefine if !matrix.is_a? Matrix
      raise ErrDimensionMismatch if matrix.m != _this.m || matrix.n != _this.n
    end

    # Make Identity matrix.
    def identity(dimension)
      id_matrix = []
      dimension.times do |x|
        id_matrix[x] = []
        dimension.times do |y|
          if x == y
            id_matrix[x][y] = 1
          else
            id_matrix[x][y] = 0
          end
        end
      end
      return id_matrix
    end

    # Multiplication of matrix row with number.
    def multiply_row(matrix, index, number)
      matrix = matrix.row(index).map{ |n| n * number }
    end

    # Format values.
    def matrix_with_values(values, col_length)
      matrixNums = values.each_slice(col_length).to_a
    end

  end


require_relative 'matrix_gem/diagonal_matrix'
require_relative 'matrix_gem/orthogonal_matrix'




