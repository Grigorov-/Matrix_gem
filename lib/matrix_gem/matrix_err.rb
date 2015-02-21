module MatrixErr

  class Matrix_Error < StandardError
  end

  class MatrixInvalidValue < StandardError
  end

  class MatrixArgumentError < Matrix_Error
  end

  class MatrixIndexOutOfRange < Matrix_Error
  end

  class ErrOperationNotDefine < Matrix_Error
    def message
      "Operation is not define!"
    end
  end

  class ErrDimensionMismatch < Matrix_Error
    def message
      "Matrices dimensions mismatch!"
    end
  end

  class NoSquareMatrix < Matrix_Error
    def message
      "Matrix should be squared!"
    end
  end

  class ErrZeroDeterminant < Matrix_Error
    def message
      "Matrix determinant should be not equal to zero!"
    end
  end
end
