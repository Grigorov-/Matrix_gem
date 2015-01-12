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

    def []=(i, j, val)
      @matrix[i][j] = val
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
        new_matrix = Matrix.new self.m, self.n, *(new_matrix_values)
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

    private

    def multiply_validation(_this, matrix)
      raise ErrDimensionMismatch if _this.n != matrix.m
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
d = Matrix.new 2,2
p d
p c
b = Matrix.new 3,2,1,3,0,-2,4,1
# p b
d[0,0] = 321
 p d







