require_relative  '../matrix_gem'

  class Diagonal_Matrix < Matrix

    # Creates a matrix by given rows, columns, and nums where the diagonal elements are composed of nums.
    # With given only rows create identity matrix.
    def initialize(rows, cols = nil, *nums)
      if cols == nil
        @matrix = identity rows
      elsif nums.length < [rows, cols].min
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

    # Creates a matrix where the diagonal elements are composed of nums.
    def self.diagonal(*nums)
      size = nums.length
      Diagonal_Matrix.new size, size, *(nums)
    end

    # Set element on main diagonal
    def []=(row_index, col_index = nil, value)
      if col_index != nil && row_index != col_index
        raise MatrixIndexOutOfRange,
        "You can set only elements on main diagonal in a diagonal matrix."
      elsif @matrix.size <= row_index
        raise MatrixIndexOutOfRange
      end
        @matrix[row_index][row_index] = value
    end
  end