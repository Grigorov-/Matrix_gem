module Properties
  # Returns an array of arrays that describe the rows of the matrix.
  def to_a
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
end