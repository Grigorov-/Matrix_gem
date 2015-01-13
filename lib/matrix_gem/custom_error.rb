module CustomError
  class Matrix_Error < StandardError
  end

  class MatrixArgumentError < Matrix_Error
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

end
