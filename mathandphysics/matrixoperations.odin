package mathandphy

import "base:intrinsics"

outer_product :: proc(x: $T/[]$E, y: $TT/[]$S) -> [][]E
    where intrinsics.type_is_numeric(E), intrinsics.type_is_numeric(S) {
    result := make([][]E, len(x))
    for i in 0..<len(x) {
        result[i] = make([]E, len(y))
        for j in 0..<len(y) {
            result[i][j] = x[i] * E( y[j] )  // Direct element-wise product
        }
    }
    return result
}


cast_outer_product :: proc($T: typeid, x: $TT/[]$E, y: $TTT/[]$S) -> [][]T
where intrinsics.type_is_numeric(T), intrinsics.type_is_numeric(E), intrinsics.type_is_numeric(S) {
    result := make([][]T, len(x))
    for i in 0..<len(x) {
        result[i] = make([]T, len(y))
        for j in 0..<len(y) {
            result[i][j] = T( x[i] ) * T( y[j] )  // Direct element-wise product
        }
    }
    return result
}
