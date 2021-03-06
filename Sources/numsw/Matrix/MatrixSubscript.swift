extension Matrix {
    /// - Returns: Single element
    public subscript(row: Int, column: Int) -> T {
        get {
            return elements[row * columns + column]
        }
        set {
            elements[row * columns + column] = newValue
        }
    }
    
    /// - Returns: Elements in the row as a row matrix
    public subscript(row: Int) -> Matrix<T> {
        get {
            return Matrix(rows: 1, columns: columns, elements: Array(elements[row * columns..<row * columns + columns]))
        }
        set {
            precondition(newValue.rows == 1, "Matrix rows must be 1.")
            precondition(newValue.columns == self.columns, "Matrices must have same columns.")
            
            for c in 0..<self.columns {
                self[row, c] = newValue[0, c]
            }
        }
    }
    
    /// - Parameters:
    ///   - rs: Indices of rows, nil means all rows
    ///   - cs: Indices of columns, nil means all columns
    /// - Returns: Submatrix
    public subscript(rs: [Int]?, cs: [Int]?) -> Matrix<T> {
        get {
            let rs = rs ?? Array(0..<rows)
            let cs = cs ?? Array(0..<columns)
            
            let newElements = UnsafeMutablePointer<T>.allocate(capacity: rs.count * cs.count)
            defer { newElements.deallocate(capacity: rs.count * cs.count) }
            var pointer = newElements
            for r in rs {
                for c in cs {
                    pointer.pointee = self[r, c]
                    pointer += 1
                }
            }
            return Matrix(rows: rs.count,
                          columns: cs.count,
                          elements: Array(UnsafeBufferPointer(start: newElements, count: rs.count * cs.count)))
        }
        set {
            let rs = rs ?? Array(0..<rows)
            let cs = cs ?? Array(0..<columns)

            precondition(newValue.rows == rs.count, "Martix shape must be corresponded")
            precondition(newValue.columns == cs.count, "Martix shape must be corresponded")
            
            for (ri, r) in rs.enumerated() {
                for (ci, c) in cs.enumerated() {
                    self[r, c] = newValue[ri, ci]
                }
            }
        }
    }
}
