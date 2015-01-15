module Properties
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

  # Retun row on index.
  def row(index)
    self[index]
  end

  # Set value of matrix row.
  def row_change(index, elements)
    self[index] = elements
  end

  # Return col on index
  # Also aliased as column()
  def col(index)
    self.each { |a| p a[index] }
  end
  alias column col

  # Returns true is this is a diagonal matrix. Raises an error if matrix is not square.
  # Also aliased as diagonal?
  def is_diagonal
    raise NoSquareMatrix if self.m != self.n
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
  def ortogonal?
    return true if ((self.is_square) && (self.transposed == self.inversed))
    false
  end
  alias is_ortogonal ortogonal?
end