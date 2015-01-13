require './matrix_gem/custom_error'
require './matrix_gem/properties_module'


  class Matrix
    include CustomError
    include Properties
    include Enumerable

    def initialize(rows, cols, *nums)
      if rows < 1 || cols < 1
        raise MatrixArgumentError, "Rows and Columns should be positive numbers!"
      elsif nums.length == 0
        @matrix = identity cols
      elsif rows * cols == nums.length
        @matrix = matrix_with_values nums, cols
      else
        raise MatrixArgumentError,
        "Wrong number of arguments (#{2 + nums.length} for #{2 + rows * cols})"
      end
      @matrix
    end

    def +(matrix)
      sum_validation(matrix, self)
      values = self.zip(matrix).map{|i| i.inject(:+)}

      Matrix.new self.m, self.n, *(values)
    end

    def -(matrix)
      sum_validation(matrix, self)
      values = self.zip(matrix).map{|i| i.inject(:-)}

      Matrix.new self.m, self.n, *(values)
    end

    def [](i, j = nil)
      if j == nil
        @matrix[i]
      else
        @matrix[i][j]
      end
    end

    def []=(i, j = nil, val)
      @matrix[i] = val if j == nil
      @matrix[i][j] = val if j != nil
    end
    alias set_element []=

    def transposed
      elements = []
      @matrix.to_a.transpose.map{ |x| x.map{ |y| elements << y } }
      Matrix.new self.m, self.n, *(elements)
    end

    def transpose
      elements = []
      @matrix.to_a.transpose.map{ |x| x.map{ |y| elements << y } }
      @matrix = elements.each_slice(@matrix[0].length).to_a
    end

    def each
      @matrix.each  do |sub_arr|
        sub_arr.each do |value|
          yield value
        end
      end
    end

    def ==(matrix)
      matrix.to_a == self.to_a
    end

    def *(m)
      case(m)
      when Numeric
        new_matrix_values = []
        self.each { |x| new_matrix_values << x * m }
        Matrix.new self.m, self.n, *(new_matrix_values)
      when Matrix
        multiply_validation self, m
        rows = Array.new(self.m) { |i|
          Array.new(m.n) { |j|
            (0 ... m.n ).inject(0)  do |vij, k|
              vij + self[i, k] * m[k, j]
            end
          }
        }
      end
    end

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
            p _this
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

    def multiply_row(matrix, index, number)
      matrix = matrix.row(index).map{ |n| n*number }
    end

    def inverse
      is_square_validation self
      raise Error if self.det == 0

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
          cauchy_method(e, i, j, -_this[j, i]/_this[i, i])

          p "_________"
          cauchy_method(_this, i, j, -_this[j, i]/_this[i, i])
          p _this
        end
      end

      p '||||||||||||||||||||||||||'

      (0..size-2).each do |i|
        (i+1..size-1).each do |j|
          cauchy_method(e, size-i-1, size-j-1, -_this[size-j-1, size-i-1]/_this[size-i-1, size-i-1])
          cauchy_method(_this, size-i-1, size-j-1, -_this[size-j-1, size-i-1]/_this[size-i-1, size-i-1])
        end
        p _this
      end

      p '|||||||||||||||||||||||||||||||||||||||'

      (0..size-1).each do |i|
        e.row_change i, multiply_row(e, i, 1/_this[i,i])
        _this.row_change i, multiply_row(_this, i, 1/_this[i,i])
      end
      p _this
      e
    end

    private

    def swap_rows(_this, row1_index, row2_index)
      _this[row1_index], _this[row2_index] = _this[row2_index], _this[row1_index]
    end

    def copy(_this)
      values = []
      _this.each{ |row| values << row}
      copy = Matrix.new _this.m, _this.n, *(values)
    end

    def cauchy_method(_this, row1, row2, multiplier)
      _this.row(row2).each_with_index { |row_element, i|
        _this.row(row2)[i] += _this[row1][i] * multiplier
      }
      _this
    end

    def multiply_validation(_this, matrix)
      raise ErrDimensionMismatch if _this.n != matrix.m
    end

    def is_square_validation(_this)
      raise NoSquareMatrix if _this.m != _this.n
    end

    def sum_validation(_this, matrix)
      raise ErrOperationNotDefine if matrix.is_a? Numeric
      raise ErrDimensionMismatch if matrix.m != _this.m || matrix.n != _this.n
    end

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

    def matrix_with_values(values, col_length)
      matrixNums = values.each_slice(col_length).to_a
    end
  end


a = Matrix.new 3,3,1,2,57,1,3,43,5,6,7
# p a
c = Matrix.new 2,2,7,9,5,2
d = Matrix.new 3,3,2,3,1,1,2,1,3,5,3
# d = Matrix.new 2,2,0,1,3,0
# d = Matrix.new 2,2,0,9,5,2


# d = Matrix.new

p d.inverse









