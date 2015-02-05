module Properties
  require_relative 'matrix_err.rb'

  include MatrixErr

  # Returns an array of arrays that describe the rows of the matrix.
  def to_a
    self
  end

  # Make all values floating point.
  def to_f
    (0..self.n - 1).each{ |i| (0..self.m - 1).each do
      |j| self[i,j] = self[i,j].to_f
      end }
    self
  end

  # Return array with values on main diagonal.
  def diagonal_values
    size = ([self.m, self.n].min) -1
    values = []

    (0..size).each do |i|
      values << self[i][i]
    end
    values
  end

  # TODO Test it!!
  # Set values on main diagonal.
  # Raise error if nums are less than matrix main diagonal length
  # Also aliased as set_diagonal_values
  def set_diagonal(*nums)
    size = ([self.m, self.n].min) -1
    raise MatrixArgumentError, 'Wrong number of arguments.' if nums.length < size + 1
    (0..size).each do |i|
      self[i,i] = nums[i]
    end
    self
  end
  alias set_diagonal_values set_diagonal

  # Returns the number of columns.
  # Also aliased as n(), col_size(), column_count()
  def col_length
    self[0].length
  end

  # Returns the number of rows.
  # Also aliased as m(), row_size(), row_count()
  def row_length
    i = 0
    self.each{ |row| i+=1 }
    i/self[0].length
  end

  alias m row_length
  alias row_size row_length
  alias row_count m


  alias n col_length
  alias col_size col_length
  alias column_count n

  # Retuns array with row on index as values.
  def row(index)
    self[index]
  end

  # Returns array with column on index as values.
  # Also aliased as column()
  def col(index)
    column = []
    (0..self.m-1).each{ |x| column << self[x, index] }
    column
  end
  alias column col

  # Set values of matrix row. Elements shoud be an array of values
  # Raise error if length of elements is not equal to matrix row length.
  def set_row(index, elements)
    raise MatrixArgumentError, 'Different length of elements and row length' if
    elements.length != self.row_length
    self[index] = elements
    self
  end

  # Set values of matrix column. Elements shoud be an array of values.
  # Raise error if length of elements is not equal to matrix column length.
  def set_col(index, elements)
    raise MatrixArgumentError, 'Different length of elements and column length' if elements.length != self.col_length
    (0..self.m-1).each{ |x| self[x, index] = elements[x] }
    self
  end

  # Returns true if there is values not equal to 0 only on main diagonal.
  # Also aliased as diagonal?
  def is_diagonal
    (0..self.m-1).each do |i|
      (0..self.m-1).each do |j|
        return false if ((self[i,j] != 0 && i != j))
      end
    end
    true
  end
  alias diagonal? is_diagonal

  # Returns true if this is a matrix with only zero elements.
  # Also aliased as is_zero
  def zero?
    self.map{ |x| return false if x != 0 }
    true
  end
  alias is_zero zero?

  # Returns true if this is a matrix with equal rows and columns.
  # Also aliased as square?
  def is_square
    return false if self.m != self.n
    true
  end
  alias square? is_square

  # Returns true if this is square matrix and its transpose is equal to its inverse.
  # Also aliased as is_zero
  def orthogonal?
    return true if ((self.is_square) && (self.transposed == self.inversed))
    false
  end
  alias is_orthogonal orthogonal?
end