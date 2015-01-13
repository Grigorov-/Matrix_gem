module Properties
  def to_a
      self
    end

    def col_length
      self[0].length
    end

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

    def row(index)
      self[index]
    end

    def row_change(index, elements)
      self[index] = elements
    end

    def col(index)
      self.each { |a| p a[index] }
    end

    alias column col
end