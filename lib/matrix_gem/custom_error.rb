module CustomError
  class Matrix_Error < StandardError
  end

  class MatrixArgumentError < Matrix_Error
  end

  class ErrOperationNotDefine < Matrix_Error
    def message
      message = "Operation is not define"
    end
  end

  class ErrDimensionMismatch < Matrix_Error
    def message
      message = "Matrices dimensions mismatch"
    end
  end
end
