module Properties
  def to_a
      self
    end

    def col_length
      self[0].length
    end

    def row_length
      self.length
    end

    alias m row_length
    alias row_size row_length
    alias row_count m



    alias n col_length
    alias col_size col_length
    alias column_count n

    def row(index)
      self[index]
    end

    def col(index)
      self.each { |a| p a[index] }
    end

    alias column col
end