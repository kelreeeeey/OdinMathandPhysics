package mathandphy

import "base:intrinsics"

outer_product_different :: proc(x: $T/[]$E, y: $TT/[]$S) -> [][]E
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


outer_product_different_types_to_target :: proc($TT: typeid, x: []$T, y: []$S) -> [][]T
where intrinsics.type_is_array(T) && intrinsics.type_is_array(S) {
    result := make([][]TT, len(x))
    for i in 0..<len(x) {
        result[i] = make([]TT, len(y))
        for j in 0..<len(y) {
            result[i][j] = TT( x[i] ) * TT( y[j] )  // Direct element-wise product
        }
    }
    return result
}


outer_product :: proc {outer_product_different, outer_product_different_types_to_target }
